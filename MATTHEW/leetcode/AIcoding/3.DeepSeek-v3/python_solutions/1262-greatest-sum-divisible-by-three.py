class Solution:
    def maxSumDivThree(self, nums: List[int]) -> int:
        dp = [0, -float('inf'), -float('inf')]
        for num in nums:
            mod = num % 3
            new_dp = dp.copy()
            for i in range(3):
                new_dp[(i + mod) % 3] = max(dp[(i + mod) % 3], dp[i] + num)
            dp = new_dp
        return dp[0]