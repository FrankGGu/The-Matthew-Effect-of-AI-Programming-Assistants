class Solution:
    def maxSumDivisibleByThree(self, nums: List[int]) -> int:
        dp = [0, float('-inf'), float('-inf')]
        for num in nums:
            new_dp = [0, 0, 0]
            for i in range(3):
                new_dp[(i + num) % 3] = max(dp[(i + num) % 3], dp[i] + num)
            dp = new_dp
        return dp[0]