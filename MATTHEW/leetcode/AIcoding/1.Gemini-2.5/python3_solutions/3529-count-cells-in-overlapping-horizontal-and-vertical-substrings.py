class Solution:
    def countCells(self, grid: list[list[str]]) -> int:
        m = len(grid)
        n = len(grid[0])

        row_counts = [0] * m
        col_counts = [0] * n

        for r in range(m):
            for c in range(n):
                if grid[r][c] == 'X':
                    row_counts[r] += 1
                    col_counts[c] += 1

        count = 0
        for r in range(m):
            for c in range(n):
                if grid[r][c] == 'X':
                    if row_counts[r] > 1 and col_counts[c] > 1:
                        count += 1

        return count