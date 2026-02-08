import math

class Solution:
    def minimizeArrayValue(self, nums: list[int]) -> int:
        current_sum = 0
        max_prefix_avg = 0

        for i in range(len(nums)):
            current_sum += nums[i]
            # The minimum possible maximum value for the prefix nums[0...i]
            # is its average, rounded up.
            # This is because values can only be moved from right to left,
            # effectively allowing redistribution within a prefix to minimize its maximum.
            avg = math.ceil(current_sum / (i + 1))
            max_prefix_avg = max(max_prefix_avg, avg)

        # The overall minimum maximum value for the entire array
        # must be at least the maximum of all such prefix averages.
        # This value is also achievable.
        return int(max_prefix_avg)