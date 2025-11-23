class Solution:
    def maxValue(self, grid: list[list[int]]) -> int:
        m = len(grid)
        n = len(grid[0])

        for i in range(m):
            for j in range(n):
                if i == 0 and j == 0:
                    continue
                elif i == 0:  # First row, can only come from left
                    grid[i][j] += grid[i][j-1]
                elif j == 0:  # First column, can only come from up
                    grid[i][j] += grid[i-1][j]
                else:  # Can come from up or left
                    grid[i][j] += max(grid[i-1][j], grid[i][j-1])

        return grid[m-1][n-1]