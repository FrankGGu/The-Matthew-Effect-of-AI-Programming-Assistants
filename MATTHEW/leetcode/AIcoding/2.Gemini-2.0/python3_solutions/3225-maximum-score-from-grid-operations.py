class Solution:
    def maxScore(self, grid: List[List[int]]) -> int:
        m, n = len(grid), len(grid[0])
        dp = [[0] * n for _ in range(m)]
        dp[0][0] = grid[0][0]
        for i in range(m):
            for j in range(n):
                if i == 0 and j == 0:
                    continue
                val = 0
                if i > 0:
                    val = max(val, dp[i - 1][j])
                if j > 0:
                    val = max(val, dp[i][j - 1])
                dp[i][j] = val + grid[i][j]
        return dp[m - 1][n - 1]