class Solution:
    def numEnclaves(self, grid: List[List[int]]) -> int:
        m, n = len(grid), len(grid[0])

        def dfs(i, j):
            if i < 0 or i >= m or j < 0 or j >= n or grid[i][j] == 0:
                return
            grid[i][j] = 0
            dfs(i + 1, j)
            dfs(i - 1, j)
            dfs(i, j + 1)
            dfs(i, j - 1)

        for i in range(m):
            for j in [0, n - 1]:
                if grid[i][j] == 1:
                    dfs(i, j)
        for j in range(n):
            for i in [0, m - 1]:
                if grid[i][j] == 1:
                    dfs(i, j)

        return sum(cell for row in grid for cell in row)