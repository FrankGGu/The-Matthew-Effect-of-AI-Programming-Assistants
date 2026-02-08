class Solution:
    def maxSquare(self, grid: List[List[int]]) -> int:
        n, m = len(grid), len(grid[0])
        max_side = 0

        dp = [[0] * m for _ in range(n)]

        for i in range(n):
            for j in range(m):
                if grid[i][j] == 1:
                    dp[i][j] = min(dp[i-1][j] if i > 0 else 0, dp[i][j-1] if j > 0 else 0, dp[i-1][j-1] if i > 0 and j > 0 else 0) + 1
                    max_side = max(max_side, dp[i][j])

        return max_side * max_side