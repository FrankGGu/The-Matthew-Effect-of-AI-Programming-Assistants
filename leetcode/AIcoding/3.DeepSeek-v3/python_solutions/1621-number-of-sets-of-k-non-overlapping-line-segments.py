class Solution:
    def numberOfSets(self, n: int, k: int) -> int:
        MOD = 10**9 + 7
        dp = [[0] * (k + 1) for _ in range(n + 1)]
        prefix = [[0] * (k + 1) for _ in range(n + 1)]

        for i in range(1, n + 1):
            dp[i][0] = 1

        for j in range(1, k + 1):
            for i in range(1, n + 1):
                prefix[i][j] = (prefix[i - 1][j] + dp[i - 1][j - 1]) % MOD
                dp[i][j] = (dp[i - 1][j] + prefix[i][j]) % MOD

        return dp[n][k]