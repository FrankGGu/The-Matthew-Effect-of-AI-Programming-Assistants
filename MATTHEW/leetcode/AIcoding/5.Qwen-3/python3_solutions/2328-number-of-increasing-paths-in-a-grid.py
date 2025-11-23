class Solution:
    def countPaths(self, grid) -> int:
        from functools import lru_cache

        MOD = 10**9 + 7
        m, n = len(grid), len(grid[0])

        @lru_cache(None)
        def dfs(i, j):
            res = 1
            for dx, dy in [(-1, 0), (1, 0), (0, -1), (0, 1)]:
                x, y = i + dx, j + dy
                if 0 <= x < m and 0 <= y < n and grid[x][y] > grid[i][j]:
                    res += dfs(x, y)
                    res %= MOD
            return res

        total = 0
        for i in range(m):
            for j in range(n):
                total += dfs(i, j)
                total %= MOD
        return total