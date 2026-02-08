class Solution:
    def countPaths(self, grid: List[List[int]]) -> int:
        mod = 10**9 + 7
        m, n = len(grid), len(grid[0])
        dp = [[0] * n for _ in range(m)]
        directions = [(1, 0), (-1, 0), (0, 1), (0, -1)]

        def dfs(x, y):
            if dp[x][y] != 0:
                return dp[x][y]
            dp[x][y] = 1
            for dx, dy in directions:
                nx, ny = x + dx, y + dy
                if 0 <= nx < m and 0 <= ny < n and grid[nx][ny] > grid[x][y]:
                    dp[x][y] += dfs(nx, ny)
                    dp[x][y] %= mod
            return dp[x][y]

        total_paths = 0
        for i in range(m):
            for j in range(n):
                total_paths += dfs(i, j)
                total_paths %= mod

        return total_paths