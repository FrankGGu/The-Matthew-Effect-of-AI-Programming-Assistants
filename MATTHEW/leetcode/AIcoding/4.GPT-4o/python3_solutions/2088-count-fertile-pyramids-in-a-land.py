class Solution:
    def countPyramids(self, grid: List[List[int]]) -> int:
        rows, cols = len(grid), len(grid[0])
        dp = [[0] * cols for _ in range(rows)]
        count = 0

        for r in range(rows):
            for c in range(cols):
                if grid[r][c] == 1:
                    if r == 0 or c == 0 or c == cols - 1:
                        dp[r][c] = 1
                    else:
                        dp[r][c] = min(dp[r - 1][c - 1], dp[r - 1][c], dp[r - 1][c + 1]) + 1
                    count += dp[r][c]

        return count