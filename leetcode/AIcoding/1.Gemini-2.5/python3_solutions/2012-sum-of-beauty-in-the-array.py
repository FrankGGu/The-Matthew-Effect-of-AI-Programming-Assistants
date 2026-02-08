class Solution:
    def sumOfBeauties(self, nums: list[int]) -> int:
        n = len(nums)
        if n < 3:
            return 0

        prefix_max = [0] * n
        suffix_min = [0] * n

        prefix_max[0] = nums[0]
        for i in range(1, n):
            prefix_max[i] = max(prefix_max[i - 1], nums[i])

        suffix_min[n - 1] = nums[n - 1]
        for i in range(n - 2, -1, -1):
            suffix_min[i] = min(suffix_min[i + 1], nums[i])

        total_beauty = 0
        for i in range(1, n - 1):
            # Condition 1: nums[i-1] < nums[i] < nums[i+1]
            cond1 = (nums[i - 1] < nums[i] < nums[i + 1])

            # Condition 2 (for beauty 2): nums[i] is greater than all elements to its left
            # AND nums[i] is smaller than all elements to its right
            cond2 = (nums[i] > prefix_max[i - 1] and nums[i] < suffix_min[i + 1])

            if cond1 and cond2:
                total_beauty += 2
            elif cond1:
                total_beauty += 1
            # else: total_beauty += 0 (no change)

        return total_beauty