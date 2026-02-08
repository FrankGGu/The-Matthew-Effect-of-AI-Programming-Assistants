class Solution:
    def deleteGreatestValue(self, grid: list[list[int]]) -> int:
        for row in grid:
            row.sort()

        total_sum = 0
        num_rows = len(grid)
        num_cols = len(grid[0])

        for j in range(num_cols):
            current_max_in_column_across_rows = 0
            for i in range(num_rows):
                current_max_in_column_across_rows = max(current_max_in_column_across_rows, grid[i][j])
            total_sum += current_max_in_column_across_rows

        return total_sum