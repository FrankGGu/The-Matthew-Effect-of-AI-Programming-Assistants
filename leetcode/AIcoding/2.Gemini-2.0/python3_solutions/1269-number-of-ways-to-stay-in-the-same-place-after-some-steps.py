class Solution:
    def numWays(self, steps: int, arrLen: int) -> int:
        arrLen = min(arrLen, steps // 2 + 1)
        dp = [[0] * arrLen for _ in range(steps + 1)]
        dp[0][0] = 1
        mod = 10**9 + 7
        for i in range(1, steps + 1):
            for j in range(arrLen):
                dp[i][j] = dp[i - 1][j]
                if j > 0:
                    dp[i][j] = (dp[i][j] + dp[i - 1][j - 1]) % mod
                if j < arrLen - 1:
                    dp[i][j] = (dp[i][j] + dp[i - 1][j + 1]) % mod
        return dp[steps][0]