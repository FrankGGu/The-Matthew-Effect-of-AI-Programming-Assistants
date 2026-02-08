class Solution:
    def numWays(self, steps: int, arrLen: int) -> int:
        MOD = 10**9 + 7
        max_pos = min(steps // 2 + 1, arrLen)
        dp = [[0] * (max_pos + 2) for _ in range(steps + 1)]
        dp[0][0] = 1

        for i in range(1, steps + 1):
            for j in range(max_pos):
                dp[i][j] = dp[i-1][j]
                if j > 0:
                    dp[i][j] += dp[i-1][j-1]
                if j < max_pos - 1:
                    dp[i][j] += dp[i-1][j+1]
                dp[i][j] %= MOD

        return dp[steps][0]