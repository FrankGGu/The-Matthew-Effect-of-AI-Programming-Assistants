class Solution:
    def satisfiesConditions(self, grid: list[list[int]]) -> bool:
        m = len(grid)
        n = len(grid[0])

        for i in range(m):
            for j in range(n - 1):
                if grid[i][j] != grid[i][j+1]:
                    return False

        for j in range(n):
            for i in range(m - 1):
                if grid[i][j] == grid[i+1][j]:
                    return False

        return True