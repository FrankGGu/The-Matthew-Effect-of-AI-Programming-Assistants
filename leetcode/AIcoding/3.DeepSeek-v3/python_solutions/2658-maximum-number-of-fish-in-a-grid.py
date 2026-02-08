class Solution:
    def findMaxFish(self, grid: List[List[int]]) -> int:
        m, n = len(grid), len(grid[0])
        max_fish = 0

        def dfs(i, j):
            if i < 0 or i >= m or j < 0 or j >= n or grid[i][j] == 0:
                return 0
            fish = grid[i][j]
            grid[i][j] = 0
            fish += dfs(i + 1, j)
            fish += dfs(i - 1, j)
            fish += dfs(i, j + 1)
            fish += dfs(i, j - 1)
            return fish

        for i in range(m):
            for j in range(n):
                if grid[i][j] > 0:
                    current_fish = dfs(i, j)
                    max_fish = max(max_fish, current_fish)

        return max_fish