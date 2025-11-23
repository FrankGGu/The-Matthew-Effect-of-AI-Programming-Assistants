class Solution:
    def maxArrayValue(self, nums: list[int]) -> int:
        n = len(nums)

        current_sum = nums[n - 1]
        max_val = current_sum

        for i in range(n - 2, -1, -1):
            if nums[i] <= current_sum:
                current_sum += nums[i]
            else:
                max_val = max(max_val, current_sum)
                current_sum = nums[i]

        max_val = max(max_val, current_sum)

        return max_val