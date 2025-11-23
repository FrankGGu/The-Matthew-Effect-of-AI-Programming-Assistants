class Solution:
    def sumOfSquares(self, nums: list[int]) -> int:
        n = len(nums)
        total_sum = 0
        for i in range(n):
            if n % (i + 1) == 0:
                total_sum += nums[i] * nums[i]
        return total_sum