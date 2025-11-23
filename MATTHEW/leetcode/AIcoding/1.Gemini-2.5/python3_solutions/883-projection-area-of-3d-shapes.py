class Solution:
    def projectionArea(self, grid: list[list[int]]) -> int:
        n = len(grid)

        xy_area = 0
        yz_area = 0
        xz_area = 0

        # Initialize lists to store maximum heights for each row and column
        # These will be used to calculate XZ and YZ projection areas
        row_maxes = [0] * n
        col_maxes = [0] * n

        for i in range(n):
            for j in range(n):
                # XY projection (top view): Each non-zero cube contributes 1 unit
                if grid[i][j] > 0:
                    xy_area += 1

                # Update maximum height for the current row (for XZ projection)
                row_maxes[i] = max(row_maxes[i], grid[i][j])

                # Update maximum height for the current column (for YZ projection)
                col_maxes[j] = max(col_maxes[j], grid[i][j])

        # Calculate XZ projection area (side view from positive y-axis)
        # This is the sum of maximum heights in each row
        xz_area = sum(row_maxes)

        # Calculate YZ projection area (front view from positive x-axis)
        # This is the sum of maximum heights in each column
        yz_area = sum(col_maxes)

        return xy_area + yz_area + xz_area