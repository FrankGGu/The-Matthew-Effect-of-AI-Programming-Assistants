class Solution:
    def numberOfPaths(self, grid: List[List[int]], k: int) -> int:
        MOD = 10**9 + 7
        m, n = len(grid), len(grid[0])
        dp = [[[0] * k for _ in range(n)] for __ in range(m)]
        dp[0][0][grid[0][0] % k] = 1

        for i in range(m):
            for j in range(n):
                if i == 0 and j == 0:
                    continue
                for mod in range(k):
                    current_mod = (mod - grid[i][j]) % k
                    if i > 0:
                        dp[i][j][mod] += dp[i-1][j][current_mod]
                    if j > 0:
                        dp[i][j][mod] += dp[i][j-1][current_mod]
                    dp[i][j][mod] %= MOD
        return dp[m-1][n-1][0]