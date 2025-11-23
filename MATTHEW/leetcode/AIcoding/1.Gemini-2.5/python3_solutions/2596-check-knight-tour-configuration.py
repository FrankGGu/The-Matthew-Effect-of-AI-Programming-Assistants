class Solution:
    def checkValidGrid(self, grid: list[list[int]]) -> bool:
        n = len(grid)
        total_cells = n * n

        if grid[0][0] != 0:
            return False

        # Store the coordinates for each number
        # positions[k] will be (r, c) where grid[r][c] == k
        positions = [None] * total_cells
        for r in range(n):
            for c in range(n):
                val = grid[r][c]
                if 0 <= val < total_cells:
                    positions[val] = (r, c)
                else:
                    # This case shouldn't happen based on problem constraints
                    # but good for robustness if values could be out of range
                    return False 

        # Check if the path is valid
        for k in range(total_cells - 1):
            r1, c1 = positions[k]
            r2, c2 = positions[k+1]

            dr = abs(r1 - r2)
            dc = abs(c1 - c2)

            # A valid knight's move has (dr, dc) as either (1, 2) or (2, 1)
            if not ((dr == 1 and dc == 2) or (dr == 2 and dc == 1)):
                return False

        return True