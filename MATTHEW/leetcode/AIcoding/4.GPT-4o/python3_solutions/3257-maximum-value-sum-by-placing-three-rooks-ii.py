class Solution:
    def maxValue(self, grid: List[List[int]]) -> int:
        row, col = len(grid), len(grid[0])
        dp = [[0] * col for _ in range(row)]

        for j in range(col):
            dp[0][j] = grid[0][j] if j == 0 else max(dp[0][j - 1], grid[0][j])

        for i in range(1, row):
            for j in range(col):
                dp[i][j] = dp[i - 1][j] + grid[i][j] if j == 0 else max(dp[i][j - 1], dp[i - 1][j] + grid[i][j])

        result = 0
        for j in range(col):
            result = max(result, dp[row - 1][j])

        return result