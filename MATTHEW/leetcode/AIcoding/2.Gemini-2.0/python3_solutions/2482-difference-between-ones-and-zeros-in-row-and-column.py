class Solution:
    def onesMinusZeros(self, grid: list[list[int]]) -> list[list[int]]:
        rows = len(grid)
        cols = len(grid[0])
        onesRow = [0] * rows
        onesCol = [0] * cols
        for i in range(rows):
            for j in range(cols):
                if grid[i][j] == 1:
                    onesRow[i] += 1
                    onesCol[j] += 1
        diff = [[0] * cols for _ in range(rows)]
        for i in range(rows):
            for j in range(cols):
                diff[i][j] = 2 * onesRow[i] + 2 * onesCol[j] - rows - cols
        return diff