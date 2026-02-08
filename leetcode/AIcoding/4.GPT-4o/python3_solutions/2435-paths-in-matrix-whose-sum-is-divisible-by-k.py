class Solution:
    def countPaths(self, grid: List[List[int]], k: int) -> int:
        mod = len(grid) % 10**9 + 7
        m, n = len(grid), len(grid[0])
        dp = [[[0] * k for _ in range(n)] for _ in range(m)]
        dp[0][0][grid[0][0] % k] = 1

        for i in range(m):
            for j in range(n):
                for mod_value in range(k):
                    if dp[i][j][mod_value] > 0:
                        if i + 1 < m:
                            new_mod = (mod_value + grid[i + 1][j]) % k
                            dp[i + 1][j][new_mod] = (dp[i + 1][j][new_mod] + dp[i][j][mod_value]) % mod
                        if j + 1 < n:
                            new_mod = (mod_value + grid[i][j + 1]) % k
                            dp[i][j + 1][new_mod] = (dp[i][j + 1][new_mod] + dp[i][j][mod_value]) % mod

        return dp[m - 1][n - 1][0]