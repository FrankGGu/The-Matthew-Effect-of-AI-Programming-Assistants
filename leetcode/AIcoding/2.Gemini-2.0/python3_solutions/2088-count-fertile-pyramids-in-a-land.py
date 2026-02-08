class Solution:
    def countFertilePyramids(self, grid: List[List[int]]) -> int:
        m, n = len(grid), len(grid[0])
        dp = [[0] * n for _ in range(m)]
        ans = 0
        for i in range(m):
            for j in range(n):
                if grid[i][j] == 1:
                    if i > 0 and j > 0 and j < n - 1:
                        dp[i][j] = min(dp[i - 1][j - 1], dp[i - 1][j], dp[i - 1][j + 1]) + 1
                    else:
                        dp[i][j] = 1
                    ans += dp[i][j]

        dp = [[0] * n for _ in range(m)]
        for i in range(m - 1, -1, -1):
            for j in range(n):
                if grid[i][j] == 1:
                    if i < m - 1 and j > 0 and j < n - 1:
                        dp[i][j] = min(dp[i + 1][j - 1], dp[i + 1][j], dp[i + 1][j + 1]) + 1
                    else:
                        dp[i][j] = 1
                    ans += dp[i][j]

        return ans - sum(sum(row) for row in grid)