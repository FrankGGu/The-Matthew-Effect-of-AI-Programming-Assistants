class Solution:
    def countTestedDevices(self, batteryPercentages: list[int]) -> int:
        tested_devices_count = 0
        decrement_for_subsequent = 0

        for i in range(len(batteryPercentages)):
            effective_battery = batteryPercentages[i] - decrement_for_subsequent
            if effective_battery > 0:
                tested_devices_count += 1
                decrement_for_subsequent += 1

        return tested_devices_count