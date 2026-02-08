class Solution:
    def countArrays(self, n: int, k: int) -> int:
        MOD = 10**9 + 7
        dp = [[0] * (k + 1) for _ in range(n + 1)]

        for i in range(1, n + 1):
            dp[i][1] = (dp[i - 1][1] * 9) % MOD
            for j in range(2, k + 1):
                dp[i][j] = (dp[i - 1][j - 1] * 9 + dp[i - 1][j] * 1) % MOD

        return dp[n][k]