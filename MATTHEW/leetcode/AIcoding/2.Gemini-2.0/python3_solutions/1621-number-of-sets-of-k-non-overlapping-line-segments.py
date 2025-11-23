class Solution:
    def numberOfSets(self, n: int, k: int) -> int:
        MOD = 10**9 + 7
        dp = [[[0] * (k + 1) for _ in range(n)] for _ in range(n)]

        for i in range(n):
            dp[i][i][0] = 1
            if i > 0:
                dp[i][i][0] = dp[i-1][i-1][0]

        for l in range(1, n):
            for i in range(n - l):
                j = i + l
                dp[i][j][0] = dp[i][j-1][0]

                for p in range(1, k + 1):
                    dp[i][j][p] = (dp[i][j-1][p] + dp[i][j-1][p-1] + dp[i][j-1][p-1] * (j-i)) % MOD

        return dp[0][n-1][k]