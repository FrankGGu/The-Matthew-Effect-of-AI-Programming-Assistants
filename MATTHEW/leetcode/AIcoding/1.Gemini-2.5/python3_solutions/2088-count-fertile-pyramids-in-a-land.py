class Solution:
    def countFertilePyramids(self, grid: list[list[int]]) -> int:
        m = len(grid)
        n = len(grid[0])

        # dp_up[r][c] stores the maximum height of a fertile pyramid
        # with its apex at (r, c), pointing downwards.
        # Initialize dp_up with values from grid.
        dp_up = [[grid[r][c] for c in range(n)] for r in range(m)]

        # Calculate dp_up values
        # Iterate from the second to last row up to the first row
        # Iterate from the second column to the second to last column
        for r in range(m - 2, -1, -1):
            for c in range(1, n - 1):
                if grid[r][c] == 1:
                    # A pyramid with apex (r, c) and height k requires:
                    # 1. grid[r][c] == 1
                    # 2. For all i from 1 to k-1, cells (r+i, c-i) to (r+i, c+i) are fertile.
                    # This means the sub-pyramids starting at (r+1, c-1), (r+1, c), and (r+1, c+1)
                    # must be sufficiently tall.
                    # Specifically, if grid[r+1][c-1], grid[r+1][c], grid[r+1][c+1] are all 1s,
                    # then a pyramid can extend. The height is 1 + the minimum height
                    # of the three potential sub-pyramids below.
                    if grid[r+1][c-1] == 1 and grid[r+1][c] == 1 and grid[r+1][c+1] == 1:
                        dp_up[r][c] = 1 + min(dp_up[r+1][c-1], dp_up[r+1][c], dp_up[r+1][c+1])
                    else:
                        dp_up[r][c] = 1 # Only height 1 pyramid possible if cannot extend
                else:
                    dp_up[r][c] = 0

        # dp_down[r][c] stores the maximum height of an inverse fertile pyramid
        # with its apex at (r, c), pointing upwards.
        # Initialize dp_down with values from grid.
        dp_down = [[grid[r][c] for c in range(n)] for r in range(m)]

        # Calculate dp_down values
        # Iterate from the second row up to the last row
        # Iterate from the second column to the second to last column
        for r in range(1, m):
            for c in range(1, n - 1):
                if grid[r][c] == 1:
                    # An inverse pyramid with apex (r, c) and height k requires:
                    # 1. grid[r][c] == 1
                    # 2. For all i from 1 to k-1, cells (r-i, c-i) to (r-i, c+i) are fertile.
                    # Similar logic to dp_up, but in reverse direction (upwards).
                    if grid[r-1][c-1] == 1 and grid[r-1][c] == 1 and grid[r-1][c+1] == 1:
                        dp_down[r][c] = 1 + min(dp_down[r-1][c-1], dp_down[r-1][c], dp_down[r-1][c+1])
                    else:
                        dp_down[r][c] = 1 # Only height 1 inverse pyramid possible if cannot extend
                else:
                    dp_down[r][c] = 0

        total_pyramids = 0
        # Count fertile pyramids of height at least 2
        for r in range(m):
            for c in range(n):
                total_pyramids += max(0, dp_up[r][c] - 1)
                total_pyramids += max(0, dp_down[r][c] - 1)

        return total_pyramids