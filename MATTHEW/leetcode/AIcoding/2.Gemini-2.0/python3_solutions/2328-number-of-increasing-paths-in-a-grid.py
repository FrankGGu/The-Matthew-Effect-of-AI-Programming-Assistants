class Solution:
    def countPaths(self, grid: List[List[int]]) -> int:
        m, n = len(grid), len(grid[0])
        dp = [[0] * n for _ in range(m)]
        MOD = 10**9 + 7

        def dfs(i, j):
            if dp[i][j] != 0:
                return dp[i][j]

            dp[i][j] = 1

            directions = [(0, 1), (0, -1), (1, 0), (-1, 0)]

            for dx, dy in directions:
                x, y = i + dx, j + dy

                if 0 <= x < m and 0 <= y < n and grid[x][y] > grid[i][j]:
                    dp[i][j] = (dp[i][j] + dfs(x, y)) % MOD

            return dp[i][j]

        ans = 0
        for i in range(m):
            for j in range(n):
                ans = (ans + dfs(i, j)) % MOD

        return ans