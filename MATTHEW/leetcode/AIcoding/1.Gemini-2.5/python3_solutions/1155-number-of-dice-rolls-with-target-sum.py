class Solution:
    def numRollsToTarget(self, n: int, f: int, target: int) -> int:
        MOD = 10**9 + 7

        dp = [[0] * (target + 1) for _ in range(n + 1)]

        dp[0][0] = 1

        for i in range(1, n + 1):
            for j in range(1, target + 1):
                for k in range(1, f + 1):
                    if j - k >= 0:
                        dp[i][j] = (dp[i][j] + dp[i-1][j-k]) % MOD

        return dp[n][target]