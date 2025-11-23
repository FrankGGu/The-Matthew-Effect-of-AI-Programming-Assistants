class Solution:
    def numberOfArithmeticSlices(self, nums: list[int]) -> int:
        n = len(nums)
        if n < 3:
            return 0

        total_slices = 0
        current_consecutive_arithmetic_length = 0

        for i in range(2, n):
            if nums[i] - nums[i-1] == nums[i-1] - nums[i-2]:
                current_consecutive_arithmetic_length += 1
                total_slices += current_consecutive_arithmetic_length
            else:
                current_consecutive_arithmetic_length = 0

        return total_slices