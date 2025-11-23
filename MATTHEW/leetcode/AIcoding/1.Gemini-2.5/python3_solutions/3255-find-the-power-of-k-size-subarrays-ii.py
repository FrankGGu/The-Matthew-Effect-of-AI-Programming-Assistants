from collections import defaultdict

class Solution:
    def findThePower(self, nums: list[int], k: int) -> list[int]:
        n = len(nums)
        if k == 0:
            return []
        if k > n:
            return []

        results = []
        current_power = 0
        freq = defaultdict(int)
        left = 0

        for right in range(n):
            val_to_add = nums[right]

            # Update current_power when adding val_to_add
            # The change in power is val_to_add * ((freq[val_to_add] + 1)^2 - freq[val_to_add]^2)
            # which simplifies to val_to_add * (2 * freq[val_to_add] + 1)
            current_power += val_to_add * (2 * freq[val_to_add] + 1)
            freq[val_to_add] += 1

            # Once the window size is k, calculate and store the power
            if right - left + 1 == k:
                results.append(current_power)

                # Remove nums[left] from the window
                val_to_remove = nums[left]

                # Update current_power when removing val_to_remove
                # The change in power is val_to_remove * ((freq[val_to_remove] - 1)^2 - freq[val_to_remove]^2)
                # which simplifies to val_to_remove * (-2 * freq[val_to_remove] + 1)
                # This is equivalent to subtracting val_to_remove * (2 * freq[val_to_remove] - 1)
                current_power -= val_to_remove * (2 * freq[val_to_remove] - 1)
                freq[val_to_remove] -= 1
                left += 1

        return results