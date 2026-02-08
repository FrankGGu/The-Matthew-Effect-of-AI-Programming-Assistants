class Solution:
    def rightTriangles(self, grid: list[list[int]]) -> int:
        m = len(grid)
        n = len(grid[0])

        row_counts = [0] * m
        col_counts = [0] * n

        # Calculate counts of '1's in each row and column
        for r in range(m):
            for c in range(n):
                if grid[r][c] == 1:
                    row_counts[r] += 1
                    col_counts[c] += 1

        total_triangles = 0

        # Iterate through the grid to find right triangles
        # For each '1' at (r, c), it can form a right angle
        # if there is at least one other '1' in its row and
        # at least one other '1' in its column.
        for r in range(m):
            for c in range(n):
                if grid[r][c] == 1:
                    # Number of other '1's in the same row
                    other_ones_in_row = row_counts[r] - 1
                    # Number of other '1's in the same column
                    other_ones_in_column = col_counts[c] - 1

                    # If both are positive, we can form triangles
                    if other_ones_in_row > 0 and other_ones_in_column > 0:
                        total_triangles += other_ones_in_row * other_ones_in_column

        return total_triangles