local HttpService = game:GetService("HttpService")
local Players = game:GetService("Players")
local player = Players.LocalPlayer
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "Mount Fvckers by RzkyO & mZZ4",
   Icon = 0,
   LoadingTitle = "mZZ4 HUB",
   LoadingSubtitle = "by RzkyO & mZZ4",
   Theme = "Default",

   DisableRayfieldPrompts = false,
   DisableBuildWarnings = false,

   ConfigurationSaving = {
      Enabled = true,
      FolderName = nil, 
      FileName = "Big Hub"
   },

   Discord = {
      Enabled = false, 
      Invite = "noinvitelink", 
      RememberJoins = true 
   },

   KeySystem = false, 
   KeySettings = {
      Title = "Untitled",
      Subtitle = "Key System",
      Note = "No method of obtaining the key is provided", 
      FileName = "Key",
      SaveKey = true, 
      GrabKeyFromSite = false,
      Key = {"Hello"} 
   }
})

-- ===== Helper =====
local function getCharacterAndHRP()
    local character = player.Character or player.CharacterAdded:Wait()
    local hrp = character:FindFirstChild("HumanoidRootPart")
    if not hrp then
        -- tunggu ulang kalau belum kebentuk
        character = player.Character or player.CharacterAdded:Wait()
        hrp = character:WaitForChild("HumanoidRootPart")
    end
    return character, hrp
end

local function resetCharacter()
    local character = player.Character
    if character then
        local humanoid = character:FindFirstChildOfClass("Humanoid")
        if humanoid then
            humanoid.Health = 0 -- biar respawn
        end
    end
end

local WAIT_SEC = 10
local USE_HEARTBEAT_TIMER = true
local RunService = game:GetService("RunService")
local function sleep(sec)
    if USE_HEARTBEAT_TIMER then
        local t = 0
        while t < sec do
            t += RunService.Heartbeat:Wait()
        end
    else
        task.wait(sec)
    end
end

local Tab = Window:CreateTab("Auto Summit")
local Section = Tab:CreateSection("- 3xplo Yang Tersedia -")

local AutoSummitYahayuk = {
    CFrame.new(-429.05, 265.50, 788.27), -- Camp 1
    CFrame.new(-359.93, 405.13, 541.62), -- Camp 2
    CFrame.new(288.24,  446.13, 506.28), -- Camp 3
    CFrame.new(336.31,  507.13, 348.97), -- Camp 4
    CFrame.new(224.20, 331.13, -144.73), -- Camp 5
    CFrame.new(-614.06, 904.50, -551.25), -- Summit
    CFrame.new(-674.25, 909.50, -481.76), -- Start
}

local AutoSummitCKPTW = {
    CFrame.new(386.77,308.18,-183.78), -- CP1
    CFrame.new(100.16,410.78,616.67), -- CP2
    CFrame.new(6.61,603.33,996.07), -- CP3
    CFrame.new(871.21,868.46,586.52), -- CP4
    CFrame.new(1612.18,1084.12,159.86), -- CP5
    CFrame.new(2965.00,1531.21,705.93), -- CP6
    CFrame.new(1811.56,1980.17,2166.88), -- SUMMIT
}

local function runOnce(points, toggleRef)
    if _G.__TP_BUSY then
        warn("Auto Summit lagi jalan, batalin start baru biar gak tabrakan.")
        pcall(function()
            if toggleRef and (toggleRef.Set or toggleRef.SetState) then
                (toggleRef.Set or toggleRef.SetState)(toggleRef, false)
            end
        end)
        return
    end
    _G.__TP_BUSY = true

    local ok, err = pcall(function()
        local character, hrp = getCharacterAndHRP()
        for i, point in ipairs(points) do
            if not hrp or not hrp.Parent then
                character, hrp = getCharacterAndHRP()
            end
            hrp.CFrame = point
            if i < #points then sleep(WAIT_SEC) end
        end
        resetCharacter()
    end)

    _G.__TP_BUSY = false

    pcall(function()
        if toggleRef and (toggleRef.Set or toggleRef.SetState) then
            (toggleRef.Set or toggleRef.SetState)(toggleRef, false)
        end
    end)

    if not ok then warn("runOnce error: " .. tostring(err)) end
end

local Toggle_A
Toggle_A = Tab:CreateToggle({
    Name = "Auto Summit Gunung Yahayuk",
    CurrentValue = false,
    Flag = "AutoTP_Toggle_A",
    Callback = function(on)
        if on then
            spawn(function()
                runOnce(AutoSummitYahayuk, Toggle_A)
            end)
        end
    end,
})

local Toggle_B
Toggle_B = Tab:CreateToggle({
    Name = "Auto Summit Gunung CKPTW",
    CurrentValue = false,
    Flag = "AutoTP_Toggle_B",
    Callback = function(on)
        if on then
            spawn(function()
                runOnce(AutoSummitCKPTW, Toggle_B)
            end)
        end
    end,
})

Rayfield:LoadConfiguration()
