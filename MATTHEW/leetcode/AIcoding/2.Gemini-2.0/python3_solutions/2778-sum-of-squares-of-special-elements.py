class Solution:
    def sumOfSquares(self, nums: List[int]) -> int:
        n = len(nums)
        sum_squares = 0
        for i in range(n):
            if (i + 1) % math.sqrt(n) == 0:
                sum_squares += nums[i] * nums[i]
        return sum_squares