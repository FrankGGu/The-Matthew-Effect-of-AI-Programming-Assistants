class Solution:
    def findZigzag(self, n: int, m: int, skip: list[list[int]]) -> list[int]:
        grid = [[0] * m for _ in range(n)]
        for r, c in skip:
            grid[r][c] = 1

        result = []
        row, col = 0, 0
        down = True

        while row < n and col < m:
            if grid[row][col] == 0:
                result.append(row * m + col)

            if down:
                if row + 1 < n and col - 1 >= 0:
                    row += 1
                    col -= 1
                else:
                    if col + 1 < m:
                        col += 1
                        down = False
                    else:
                        row += 1
                        down = False
            else:
                if row - 1 >= 0 and col + 1 < m:
                    row -= 1
                    col += 1
                else:
                    if row + 1 < n:
                        row += 1
                        down = True
                    else:
                        col += 1
                        down = True

        return result