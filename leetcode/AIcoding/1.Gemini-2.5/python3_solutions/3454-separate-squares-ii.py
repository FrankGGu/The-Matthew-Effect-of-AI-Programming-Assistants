class Solution:
    def separateSquaresII(self, grid: list[list[str]]) -> int:
        if not grid or not grid[0]:
            return 0

        rows = len(grid)
        cols = len(grid[0])

        count = 0

        def check_square(r, c, size):
            for i in range(r, r + size):
                for j in range(c, c + size):
                    if grid[i][j] == '0':
                        return False
            return True

        def erase_square(r, c, size):
            for i in range(r, r + size):
                for j in range(c, c + size):
                    grid[i][j] = '0'

        for r in range(rows):
            for c in range(cols):
                if grid[r][c] == '1':
                    count += 1

                    max_s = 0
                    for s in range(1, min(rows - r, cols - c) + 1):
                        if check_square(r, c, s):
                            max_s = s
                        else:
                            break

                    erase_square(r, c, max_s)

        return count