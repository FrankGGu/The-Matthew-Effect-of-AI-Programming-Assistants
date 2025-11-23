class Solution:
    def surfaceArea(self, grid: List[List[int]]) -> int:
        n = len(grid)
        surface = 0
        for i in range(n):
            for j in range(n):
                if grid[i][j] > 0:
                    surface += 2
                    for dx, dy in [(0,1),(1,0),(-1,0),(0,-1)]:
                        ni, nj = i + dx, j + dy
                        if 0 <= ni < n and 0 <= nj < n:
                            surface += max(0, grid[i][j] - grid[ni][nj])
                        else:
                            surface += grid[i][j]
        return surface