class Solution:
    def surfaceArea(self, grid: List[List[int]]) -> int:
        n = len(grid)
        area = 0
        for i in range(n):
            for j in range(n):
                if grid[i][j] > 0:
                    area += 2
                    area += grid[i][j] * 4
                    if i > 0:
                        area -= min(grid[i][j], grid[i-1][j])
                        area -= min(grid[i][j], grid[i-1][j])
                    if i < n - 1:
                        area -= min(grid[i][j], grid[i+1][j])
                        area -= min(grid[i][j], grid[i+1][j])
                    if j > 0:
                        area -= min(grid[i][j], grid[i][j-1])
                        area -= min(grid[i][j], grid[i][j-1])
                    if j < n - 1:
                        area -= min(grid[i][j], grid[i][j+1])
                        area -= min(grid[i][j], grid[i][j+1])
        return area