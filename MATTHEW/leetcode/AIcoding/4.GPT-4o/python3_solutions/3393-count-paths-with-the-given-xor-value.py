class Solution:
    def countPaths(self, grid: List[List[int]], x: int) -> int:
        m, n = len(grid), len(grid[0])
        mod = 10**9 + 7
        dp = [[[0] * (1024) for _ in range(n)] for __ in range(m)]
        dp[0][0][grid[0][0]] = 1

        for i in range(m):
            for j in range(n):
                for k in range(1024):
                    if dp[i][j][k] > 0:
                        if i + 1 < m:
                            dp[i + 1][j][k ^ grid[i + 1][j]] = (dp[i + 1][j][k ^ grid[i + 1][j]] + dp[i][j][k]) % mod
                        if j + 1 < n:
                            dp[i][j + 1][k ^ grid[i][j + 1]] = (dp[i][j + 1][k ^ grid[i][j + 1]] + dp[i][j][k]) % mod

        return dp[m - 1][n - 1][x]