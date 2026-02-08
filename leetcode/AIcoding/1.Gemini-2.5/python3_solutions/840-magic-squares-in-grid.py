class Solution:
    def numMagicSquaresInside(self, grid: list[list[int]]) -> int:
        R, C = len(grid), len(grid[0])
        if R < 3 or C < 3:
            return 0

        count = 0

        def is_magic(r, c):
            # Check center element (optimization: must be 5 for 3x3 magic square with 1-9)
            if grid[r+1][c+1] != 5:
                return False

            nums = set()
            for i in range(3):
                for j in range(3):
                    val = grid[r+i][c+j]
                    # Check if number is within 1-9 range
                    if not (1 <= val <= 9):
                        return False
                    nums.add(val)

            # Check if all numbers from 1 to 9 are present exactly once
            if len(nums) != 9:
                return False

            # Check all 8 sums (rows, columns, diagonals) must be 15
            # Rows
            if not (grid[r][c] + grid[r][c+1] + grid[r][c+2] == 15 and
                    grid[r+1][c] + grid[r+1][c+1] + grid[r+1][c+2] == 15 and
                    grid[r+2][c] + grid[r+2][c+1] + grid[r+2][c+2] == 15):
                return False
            # Columns
            if not (grid[r][c] + grid[r+1][c] + grid[r+2][c] == 15 and
                    grid[r][c+1] + grid[r+1][c+1] + grid[r+2][c+1] == 15 and
                    grid[r][c+2] + grid[r+1][c+2] + grid[r+2][c+2] == 15):
                return False
            # Diagonals
            if not (grid[r][c] + grid[r+1][c+1] + grid[r+2][c+2] == 15 and
                    grid[r][c+2] + grid[r+1][c+1] + grid[r+2][c] == 15):
                return False

            return True

        for r in range(R - 2):
            for c in range(C - 2):
                if is_magic(r, c):
                    count += 1

        return count