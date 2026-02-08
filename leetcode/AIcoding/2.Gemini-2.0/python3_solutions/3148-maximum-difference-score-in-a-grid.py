class Solution:
    def maxDiff(self, grid: list[list[int]]) -> int:
        m, n = len(grid), len(grid[0])
        max_diff = -1
        min_val = grid[0][0]
        for i in range(m):
            for j in range(n):
                if grid[i][j] > min_val:
                    max_diff = max(max_diff, grid[i][j] - min_val)
                min_val = min(min_val, grid[i][j])
        return max_diff