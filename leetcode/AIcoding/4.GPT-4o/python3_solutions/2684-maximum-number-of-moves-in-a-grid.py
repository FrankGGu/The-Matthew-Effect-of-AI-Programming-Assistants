class Solution:
    def maxMoves(self, grid: List[List[int]]) -> int:
        m, n = len(grid), len(grid[0])
        dp = [[1] * n for _ in range(m)]

        for i in range(m - 2, -1, -1):
            for j in range(n):
                if j > 0 and grid[i][j] < grid[i + 1][j - 1]:
                    dp[i][j] = max(dp[i][j], dp[i + 1][j - 1] + 1)
                if grid[i][j] < grid[i + 1][j]:
                    dp[i][j] = max(dp[i][j], dp[i + 1][j] + 1)
                if j < n - 1 and grid[i][j] < grid[i + 1][j + 1]:
                    dp[i][j] = max(dp[i][j], dp[i + 1][j + 1] + 1)

        return max(dp[0])