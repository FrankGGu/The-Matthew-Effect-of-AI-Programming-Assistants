from typing import List

class Solution:
    def closedIsland(self, grid: List[List[int]]) -> int:
        m = len(grid)
        n = len(grid[0])

        def dfs(r, c):
            if not (0 <= r < m and 0 <= c < n) or grid[r][c] == 1:
                return

            grid[r][c] = 1

            dfs(r + 1, c)
            dfs(r - 1, c)
            dfs(r, c + 1)
            dfs(r, c - 1)

        for c in range(n):
            if grid[0][c] == 0:
                dfs(0, c)
            if grid[m - 1][c] == 0:
                dfs(m - 1, c)

        for r in range(m):
            if grid[r][0] == 0:
                dfs(r, 0)
            if grid[r][n - 1] == 0:
                dfs(r, n - 1)

        closed_islands_count = 0
        for r in range(m):
            for c in range(n):
                if grid[r][c] == 0:
                    closed_islands_count += 1
                    dfs(r, c)

        return closed_islands_count