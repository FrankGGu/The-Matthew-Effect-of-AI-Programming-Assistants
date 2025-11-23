class Solution:
    def findColumnWidth(self, grid: list[list[int]]) -> list[int]:
        num_rows = len(grid)
        num_cols = len(grid[0])

        max_widths = [0] * num_cols

        for r in range(num_rows):
            for c in range(num_cols):
                num_str = str(grid[r][c])
                current_width = len(num_str)
                max_widths[c] = max(max_widths[c], current_width)

        return max_widths