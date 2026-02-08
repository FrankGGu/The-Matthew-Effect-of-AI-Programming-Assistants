class Solution:
    def tilingRectangle(self, n: int, m: int) -> int:
        dp = [[float('inf')] * (m + 1) for _ in range(n + 1)]
        dp[0][0] = 0

        for i in range(n + 1):
            for j in range(m + 1):
                if i == 0 and j == 0:
                    continue
                for k in range(1, min(i, j) + 1):
                    dp[i][j] = min(dp[i][j], dp[i - k][j] + dp[k][j - k] + 1)
                for k in range(1, i + 1):
                    dp[i][j] = min(dp[i][j], dp[i - k][j] + 1)
                for k in range(1, j + 1):
                    dp[i][j] = min(dp[i][j], dp[i][j - k] + 1)

        return dp[n][m]