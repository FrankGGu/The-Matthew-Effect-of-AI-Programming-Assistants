class Solution:
    def countSpecialSubsequences(self, nums: List[int]) -> int:
        MOD = 10**9 + 7
        n = len(nums)
        dp = [[0] * 4 for _ in range(n + 1)]

        for i in range(n + 1):
            dp[i][0] = 1

        for i in range(1, n + 1):
            for j in range(4):
                dp[i][j] = dp[i - 1][j]
                if nums[i - 1] == j:
                    dp[i][j] += dp[i - 1][j - 1]
                    dp[i][j] %= MOD

        return (dp[n][3] - 1) % MOD