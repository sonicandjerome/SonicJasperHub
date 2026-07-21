-- LIGHTWEIGHT ORION UI FOR MOBILE EXECUTORS
local OrionLib = loadstring(game:HttpGet(('https://githubusercontent.com')))()

local Window = OrionLib:MakeWindow({
    Name = "SONICANDJASPER FIRST SCRIPT HUB", 
    HidePremium = false, 
    SaveConfig = true, 
    ConfigFolder = "sonicj",
    IntroText = "loading pls wait jasper needs it"
})

-- Variables for features
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")

local AimbotEnabled = false
local InfiniteJumpEnabled = false
local WalkSpeedValue = 16
local JumpPowerValue = 50

-- Helper function to find the closest player for Aimbot
local function getClosestPlayer()
    local closestPlayer = nil
    local shortestDistance = math.huge
    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") and player.Character:FindFirstChild("Humanoid") and player.Character.Humanoid.Health > 0 then
            local pos, onScreen = Camera:WorldToViewportPoint(player.Character.HumanoidRootPart.Position)
            if onScreen then
                local mousePos = Vector2.new(LocalPlayer:GetMouse().X, LocalPlayer:GetMouse().Y)
                local distance = (Vector2.new(pos.X, pos.Y) - mousePos).Magnitude
                if distance < shortestDistance then
                    closestPlayer = player
                    shortestDistance = distance
                end
            end
        end
    end
    return closestPlayer
end

-- Aimbot Loop
RunService.RenderStepped:Connect(function()
    if AimbotEnabled then
        local target = getClosestPlayer()
        if target and target.Character and target.Character:FindFirstChild("HumanoidRootPart") then
            Camera.CFrame = CFrame.new(Camera.CFrame.Position, target.Character.HumanoidRootPart.Position)
        end
    end
end)

-- Infinite Jump Logic
UserInputService.JumpRequest:Connect(function()
    if InfiniteJumpEnabled then
        local Character = LocalPlayer.Character
        if Character and Character:FindFirstChildOfClass("Humanoid") then
            Character:FindFirstChildOfClass("Humanoid"):ChangeState(Enum.HumanoidStateType.Jumping)
        end
    end
end)

-- Loop to keep custom speed/jump active when respawning
LocalPlayer.CharacterAdded:Connect(function(char)
    local humanoid = char:WaitForChild("Humanoid")
    humanoid.WalkSpeed = WalkSpeedValue
    humanoid.JumpPower = JumpPowerValue
end)


-- TAB 1: AIMBOT
local AimbotTab = Window:MakeTab({
    Name = "Aimbot",
    Icon = "rbxassetid://4483345998",
    PremiumOnly = false
})

AimbotTab:AddToggle({
    Name = "Toggle Aimbot",
    Default = false,
    Callback = function(Value)
        AimbotEnabled = Value
    end    
})


-- TAB 2: PLAYER
local PlayerTab = Window:MakeTab({
    Name = "Player",
    Icon = "rbxassetid://4483345998",
    PremiumOnly = false
})

PlayerTab:AddSlider({
    Name = "Walkspeed",
    Min = 16,
    Max = 250,
    Default = 16,
    Color = Color3.fromRGB(0,100,255),
    Increment = 1,
    ValueName = "Speed",
    Callback = function(Value)
        WalkSpeedValue = Value
        if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
            LocalPlayer.Character.Humanoid.WalkSpeed = Value
        end
    end    
})

PlayerTab:AddSlider({
    Name = "Jump Power",
    Min = 50,
    Max = 500,
    Default = 50,
    Color = Color3.fromRGB(0,255,100),
    Increment = 1,
    ValueName = "Power",
    Callback = function(Value)
        JumpPowerValue = Value
        if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
            LocalPlayer.Character.Humanoid.JumpPower = Value
        end
    end    
})

PlayerTab:AddToggle({
    Name = "Infinite Jump",
    Default = false,
    Callback = function(Value)
        InfiniteJumpEnabled = Value
    end    
})

OrionLib:Init()
local WalkSpeedValue = 16
local JumpPowerValue = 50

-- Helper function to find the closest player for Aimbot
local function getClosestPlayer()
    local closestPlayer = nil
    local shortestDistance = math.huge

    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") and player.Character:FindFirstChild("Humanoid") and player.Character.Humanoid.Health > 0 then
            local pos, onScreen = Camera:WorldToViewportPoint(player.Character.HumanoidRootPart.Position)
            if onScreen then
                local mousePos = Vector2.new(LocalPlayer:GetMouse().X, LocalPlayer:GetMouse().Y)
                local distance = (Vector2.new(pos.X, pos.Y) - mousePos).Magnitude
                if distance < shortestDistance then
                    closestPlayer = player
                    shortestDistance = distance
                end
            end
        end
    end
    return closestPlayer
end

-- Aimbot Loop
RunService.RenderStepped:Connect(function()
    if AimbotEnabled then
        local target = getClosestPlayer()
        if target and target.Character and target.Character:FindFirstChild("HumanoidRootPart") then
            Camera.CFrame = CFrame.new(Camera.CFrame.Position, target.Character.HumanoidRootPart.Position)
        end
    end
end)

-- Infinite Jump Logic
UserInputService.JumpRequest:Connect(function()
    if InfiniteJumpEnabled then
        local Character = LocalPlayer.Character
        if Character and Character:FindFirstChildOfClass("Humanoid") then
            Character:FindFirstChildOfClass("Humanoid"):ChangeState(Enum.HumanoidStateType.Jumping)
        end
    end
end)

-- TAB 1: AIMBOT
local aimbotTab = Window:CreateTab("Aimbot", "crosshair")
local Section = aimbotTab:CreateSection("Aimbot Settings")

local Toggle = aimbotTab:CreateToggle({
    Name = "Toggle Aimbot",
    CurrentValue = false,
    Flag = "AimbotToggle",
    Callback = function(Value)
        AimbotEnabled = Value
    end,
})

-- TAB 2: LOCAL PLAYER (Movement hacks)
local playerTab = Window:CreateTab("Player", "user")
local PlayerSection = playerTab:CreateSection("Movement")

-- Walkspeed Slider
local SpeedSlider = playerTab:CreateSlider({
    Name = "Walkspeed",
    Info = "Changes your movement speed.",
    Min = 16,
    Max = 250,
    CurrentValue = 16,
    Flag = "SpeedSlider",
    Callback = function(Value)
        WalkSpeedValue = Value
        if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
            LocalPlayer.Character.Humanoid.WalkSpeed = Value
        end
    end,
})

-- Jump Power Slider
local JumpSlider = playerTab:CreateSlider({
    Name = "Jump Power",
    Info = "Changes how high you jump.",
    Min = 50,
    Max = 500,
    CurrentValue = 50,
    Flag = "JumpSlider",
    Callback = function(Value)
        JumpPowerValue = Value
        if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
            LocalPlayer.Character.Humanoid.JumpPower = Value
        end
    end,
})

-- Infinite Jump Toggle
local InfJumpToggle = playerTab:CreateToggle({
    Name = "Infinite Jump",
    CurrentValue = false,
    Flag = "InfJumpToggle",
    Callback = function(Value)
        InfiniteJumpEnabled = Value
    end,
})

-- Fly Toggle
local FlyToggle = playerTab:CreateToggle({
    Name = "Fly (E to toggle air-glide)",
    CurrentValue = false,
    Flag = "FlyToggle",
    Callback = function(Value)
        FlyEnabled = Value
        local HumanoidRootPart = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
        if not HumanoidRootPart then return end
        
        if FlyEnabled then
            local bv = Instance.new("BodyVelocity")
            bv.Name = "SonicFly"
            bv.Velocity = Vector3.new(0, 0.1, 0)
            bv.MaxForce = Vector3.new(0, math.huge, 0)
            bv.Parent = HumanoidRootPart
        else
            if HumanoidRootPart:FindFirstChild("SonicFly") then
                HumanoidRootPart.SonicFly:Destroy()
            end
        end
    end,
})

-- Loop to ensure custom speed/jump stay active when respawning
LocalPlayer.CharacterAdded:Connect(function(char)
    local humanoid = char:WaitForChild("Humanoid")
    humanoid.WalkSpeed = WalkSpeedValue
    humanoid.JumpPower = JumpPowerValue
end)

-- Notification on execution
Rayfield:Notify({
    Title = "lets gooo",
    Content = "sonicandjasper first script hub loaded",
    Duration = 6.5,
    Image = 4483362458,
})
local JumpPowerValue = 50

-- Helper function to find the closest player for Aimbot
local function getClosestPlayer()
    local closestPlayer = nil
    local shortestDistance = math.huge

    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") and player.Character:FindFirstChild("Humanoid") and player.Character.Humanoid.Health > 0 then
            local pos, onScreen = Camera:WorldToViewportPoint(player.Character.HumanoidRootPart.Position)
            if onScreen then
                local mousePos = Vector2.new(LocalPlayer:GetMouse().X, LocalPlayer:GetMouse().Y)
                local distance = (Vector2.new(pos.X, pos.Y) - mousePos).Magnitude
                if distance < shortestDistance then
                    closestPlayer = player
                    shortestDistance = distance
                end
            end
        end
    end
    return closestPlayer
end

-- Aimbot Loop
RunService.RenderStepped:Connect(function()
    if AimbotEnabled then
        local target = getClosestPlayer()
        if target and target.Character and target.Character:FindFirstChild("HumanoidRootPart") then
            Camera.CFrame = CFrame.new(Camera.CFrame.Position, target.Character.HumanoidRootPart.Position)
        end
    end
end)

-- Infinite Jump Logic
UserInputService.JumpRequest:Connect(function()
    if InfiniteJumpEnabled then
        local Character = LocalPlayer.Character
        if Character and Character:FindFirstChildOfClass("Humanoid") then
            Character:FindFirstChildOfClass("Humanoid"):ChangeState(Enum.HumanoidStateType.Jumping)
        end
    end
end)

-- TAB 1: AIMBOT
local aimbotTab = Window:CreateTab("Aimbot", "crosshair")
local Section = aimbotTab:CreateSection("Aimbot Settings")

local Toggle = aimbotTab:CreateToggle({
    Name = "Toggle Aimbot",
    CurrentValue = false,
    Flag = "AimbotToggle",
    Callback = function(Value)
        AimbotEnabled = Value
    end,
})

-- TAB 2: LOCAL PLAYER (Movement hacks)
local playerTab = Window:CreateTab("Player", "user")
local PlayerSection = playerTab:CreateSection("Movement")

-- Walkspeed Slider
local SpeedSlider = playerTab:CreateSlider({
    Name = "Walkspeed",
    Info = "Changes your movement speed.",
    Min = 16,
    Max = 250,
    CurrentValue = 16,
    Flag = "SpeedSlider",
    Callback = function(Value)
        WalkSpeedValue = Value
        if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
            LocalPlayer.Character.Humanoid.WalkSpeed = Value
        end
    end,
})

-- Jump Power Slider
local JumpSlider = playerTab:CreateSlider({
    Name = "Jump Power",
    Info = "Changes how high you jump.",
    Min = 50,
    Max = 500,
    CurrentValue = 50,
    Flag = "JumpSlider",
    Callback = function(Value)
        JumpPowerValue = Value
        if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
            LocalPlayer.Character.Humanoid.JumpPower = Value
        end
    end,
})

-- Infinite Jump Toggle
local InfJumpToggle = playerTab:CreateToggle({
    Name = "Infinite Jump",
    CurrentValue = false,
    Flag = "InfJumpToggle",
    Callback = function(Value)
        InfiniteJumpEnabled = Value
    end,
})

-- Fly Toggle
local FlyToggle = playerTab:CreateToggle({
    Name = "Fly (E to toggle air-glide)",
    CurrentValue = false,
    Flag = "FlyToggle",
    Callback = function(Value)
        FlyEnabled = Value
        local HumanoidRootPart = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
        if not HumanoidRootPart then return end
        
        if FlyEnabled then
            local bv = Instance.new("BodyVelocity")
            bv.Name = "SonicFly"
            bv.Velocity = Vector3.new(0, 0.1, 0)
            bv.MaxForce = Vector3.new(0, math.huge, 0)
            bv.Parent = HumanoidRootPart
        else
            if HumanoidRootPart:FindFirstChild("SonicFly") then
                HumanoidRootPart.SonicFly:Destroy()
            end
        end
    end,
})

-- Loop to ensure custom speed/jump stay active when respawning
LocalPlayer.CharacterAdded:Connect(function(char)
    local humanoid = char:WaitForChild("Humanoid")
    humanoid.WalkSpeed = WalkSpeedValue
    humanoid.JumpPower = JumpPowerValue
end)

-- Notification on execution
Rayfield:Notify({
    Title = "lets gooo",
    Content = "sonicandjasper first script hub loaded",
    Duration = 6.5,
    Image = 4483362458,
})
local JumpPowerValue = 50

-- Helper function to find the closest player for Aimbot
local function getClosestPlayer()
    local closestPlayer = nil
    local shortestDistance = math.huge

    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") and player.Character:FindFirstChild("Humanoid") and player.Character.Humanoid.Health > 0 then
            local pos, onScreen = Camera:WorldToViewportPoint(player.Character.HumanoidRootPart.Position)
            if onScreen then
                local mousePos = Vector2.new(LocalPlayer:GetMouse().X, LocalPlayer:GetMouse().Y)
                local distance = (Vector2.new(pos.X, pos.Y) - mousePos).Magnitude
                if distance < shortestDistance then
                    closestPlayer = player
                    shortestDistance = distance
                end
            end
        end
    end
    return closestPlayer
end

-- Aimbot Loop
RunService.RenderStepped:Connect(function()
    if AimbotEnabled then
        local target = getClosestPlayer()
        if target and target.Character and target.Character:FindFirstChild("HumanoidRootPart") then
            Camera.CFrame = CFrame.new(Camera.CFrame.Position, target.Character.HumanoidRootPart.Position)
        end
    end
end)

-- Infinite Jump Logic
UserInputService.JumpRequest:Connect(function()
    if InfiniteJumpEnabled then
        local Character = LocalPlayer.Character
        if Character and Character:FindFirstChildOfClass("Humanoid") then
            Character:FindFirstChildOfClass("Humanoid"):ChangeState(Enum.HumanoidStateType.Jumping)
        end
    end
end)

-- TAB 1: AIMBOT
local aimbotTab = Window:CreateTab("Aimbot", "crosshair")
local Section = aimbotTab:CreateSection("Aimbot Settings")

local Toggle = aimbotTab:CreateToggle({
    Name = "Toggle Aimbot",
    CurrentValue = false,
    Flag = "AimbotToggle",
    Callback = function(Value)
        AimbotEnabled = Value
    end,
})

-- TAB 2: LOCAL PLAYER (Movement hacks)
local playerTab = Window:CreateTab("Player", "user")
local PlayerSection = playerTab:CreateSection("Movement")

-- Walkspeed Slider
local SpeedSlider = playerTab:CreateSlider({
    Name = "Walkspeed",
    Info = "Changes your movement speed.",
    Min = 16,
    Max = 250,
    CurrentValue = 16,
    Flag = "SpeedSlider",
    Callback = function(Value)
        WalkSpeedValue = Value
        if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
            LocalPlayer.Character.Humanoid.WalkSpeed = Value
        end
    end,
})

-- Jump Power Slider
local JumpSlider = playerTab:CreateSlider({
    Name = "Jump Power",
    Info = "Changes how high you jump.",
    Min = 50,
    Max = 500,
    CurrentValue = 50,
    Flag = "JumpSlider",
    Callback = function(Value)
        JumpPowerValue = Value
        if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
            LocalPlayer.Character.Humanoid.JumpPower = Value
        end
    end,
})

-- Infinite Jump Toggle
local InfJumpToggle = playerTab:CreateToggle({
    Name = "Infinite Jump",
    CurrentValue = false,
    Flag = "InfJumpToggle",
    Callback = function(Value)
        InfiniteJumpEnabled = Value
    end,
})

-- Fly Toggle
local FlyToggle = playerTab:CreateToggle({
    Name = "Fly (E to toggle air-glide)",
    CurrentValue = false,
    Flag = "FlyToggle",
    Callback = function(Value)
        FlyEnabled = Value
        local HumanoidRootPart = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
        if not HumanoidRootPart then return end
        
        if FlyEnabled then
            local bv = Instance.new("BodyVelocity")
            bv.Name = "SonicFly"
            bv.Velocity = Vector3.new(0, 0.1, 0)
            bv.MaxForce = Vector3.new(0, math.huge, 0)
            bv.Parent = HumanoidRootPart
        else
            if HumanoidRootPart:FindFirstChild("SonicFly") then
                HumanoidRootPart.SonicFly:Destroy()
            end
        end
    end,
})

-- Loop to ensure custom speed/jump stay active when respawning
LocalPlayer.CharacterAdded:Connect(function(char)
    local humanoid = char:WaitForChild("Humanoid")
    humanoid.WalkSpeed = WalkSpeedValue
    humanoid.JumpPower = JumpPowerValue
end)

-- Notification on execution
Rayfield:Notify({
    Title = "lets gooo",
    Content = "sonicandjasper first script hub loaded",
    Duration = 6.5,
    Image = 4483362458,
})
