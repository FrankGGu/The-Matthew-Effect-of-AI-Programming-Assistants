class Solution:
    def countSpecialSubsequences(self, nums: List[int]) -> int:
        MOD = 10**9 + 7
        n = len(nums)
        dp = [[0] * 4 for _ in range(n + 1)]
        dp[0][0] = 1

        for i in range(1, n + 1):
            for j in range(4):
                dp[i][j] = dp[i - 1][j]

            if nums[i - 1] == 0:
                dp[i][0] = (dp[i][0] + dp[i - 1][0]) % MOD
            elif nums[i - 1] == 1:
                dp[i][1] = (dp[i][1] + dp[i - 1][0]) % MOD
                dp[i][1] = (dp[i][1] + dp[i - 1][1]) % MOD
            elif nums[i - 1] == 2:
                dp[i][2] = (dp[i][2] + dp[i - 1][1]) % MOD
                dp[i][2] = (dp[i][2] + dp[i - 1][2]) % MOD
            elif nums[i - 1] == 3:
                dp[i][3] = (dp[i][3] + dp[i - 1][2]) % MOD
                dp[i][3] = (dp[i][3] + dp[i - 1][3]) % MOD

        return dp[n][3]