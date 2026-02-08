class Solution:
    def maxValue(self, grid: List[List[int]]) -> int:
        n, m = len(grid), len(grid[0])
        dp = [[0] * m for _ in range(n)]

        for i in range(n):
            for j in range(m):
                dp[i][j] = grid[i][j]
                if i > 0:
                    dp[i][j] = max(dp[i][j], dp[i-1][j] + grid[i][j])
                if j > 0:
                    dp[i][j] = max(dp[i][j], dp[i][j-1] + grid[i][j])

        max_sum = 0
        for i in range(n):
            for j in range(m):
                for k in range(m):
                    if j != k:
                        max_sum = max(max_sum, dp[i][j] + dp[i][k] - grid[i][j] - grid[i][k])

        return max_sum