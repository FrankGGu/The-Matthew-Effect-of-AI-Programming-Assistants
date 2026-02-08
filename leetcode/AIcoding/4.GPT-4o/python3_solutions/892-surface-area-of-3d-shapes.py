class Solution:
    def surfaceArea(self, grid: List[List[int]]) -> int:
        total_area = 0
        for i in range(len(grid)):
            for j in range(len(grid[0])):
                if grid[i][j] > 0:
                    total_area += grid[i][j] * 6 - (grid[i][j] - 1) * 2
                    if i > 0:
                        total_area -= min(grid[i][j], grid[i - 1][j]) * 2
                    if j > 0:
                        total_area -= min(grid[i][j], grid[i][j - 1]) * 2
        return total_area