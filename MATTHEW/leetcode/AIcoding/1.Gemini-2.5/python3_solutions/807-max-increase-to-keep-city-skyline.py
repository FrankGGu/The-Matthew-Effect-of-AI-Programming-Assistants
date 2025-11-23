class Solution:
    def maxIncreaseKeepingSkyline(self, grid: list[list[int]]) -> int:
        n = len(grid)

        row_maxes = [0] * n
        col_maxes = [0] * n

        for r in range(n):
            for c in range(n):
                row_maxes[r] = max(row_maxes[r], grid[r][c])
                col_maxes[c] = max(col_maxes[c], grid[r][c])

        total_increase = 0
        for r in range(n):
            for c in range(n):
                max_possible_height = min(row_maxes[r], col_maxes[c])
                total_increase += (max_possible_height - grid[r][c])

        return total_increase