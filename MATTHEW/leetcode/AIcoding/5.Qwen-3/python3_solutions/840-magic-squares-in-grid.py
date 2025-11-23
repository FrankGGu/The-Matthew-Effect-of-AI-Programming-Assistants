class Solution:
    def numMagicSquaresIn(self, grid: List[List[int]]) -> int:
        def is_magic(grid, r, c):
            s = set()
            for i in range(r, r + 3):
                for j in range(c, c + 3):
                    if grid[i][j] < 1 or grid[i][j] > 9:
                        return False
                    s.add(grid[i][j])
            if len(s) != 9:
                return False
            magic_sum = grid[r][c] + grid[r][c + 1] + grid[r][c + 2]
            if (grid[r + 1][c] + grid[r + 1][c + 1] + grid[r + 1][c + 2]) != magic_sum:
                return False
            if (grid[r + 2][c] + grid[r + 2][c + 1] + grid[r + 2][c + 2]) != magic_sum:
                return False
            if (grid[r][c] + grid[r + 1][c] + grid[r + 2][c]) != magic_sum:
                return False
            if (grid[r][c + 1] + grid[r + 1][c + 1] + grid[r + 2][c + 1]) != magic_sum:
                return False
            if (grid[r][c + 2] + grid[r + 1][c + 2] + grid[r + 2][c + 2]) != magic_sum:
                return False
            if (grid[r][c] + grid[r + 1][c + 1] + grid[r + 2][c + 2]) != magic_sum:
                return False
            if (grid[r][c + 2] + grid[r + 1][c + 1] + grid[r + 2][c]) != magic_sum:
                return False
            return True

        count = 0
        rows = len(grid)
        cols = len(grid[0]) if rows > 0 else 0
        for r in range(rows - 2):
            for c in range(cols - 2):
                if is_magic(grid, r, c):
                    count += 1
        return count