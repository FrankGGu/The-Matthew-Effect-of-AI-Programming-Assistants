class Solution:
    def maxProductPath(self, grid: List[List[int]]) -> int:
        m, n = len(grid), len(grid[0])
        max_dp = [[0] * n for _ in range(m)]
        min_dp = [[0] * n for _ in range(m)]

        max_dp[0][0] = min_dp[0][0] = grid[0][0]

        for i in range(1, m):
            max_dp[i][0] = min_dp[i][0] = max_dp[i-1][0] * grid[i][0]

        for j in range(1, n):
            max_dp[0][j] = min_dp[0][j] = max_dp[0][j-1] * grid[0][j]

        for i in range(1, m):
            for j in range(1, n):
                if grid[i][j] > 0:
                    max_dp[i][j] = max(max_dp[i-1][j], max_dp[i][j-1]) * grid[i][j]
                    min_dp[i][j] = min(min_dp[i-1][j], min_dp[i][j-1]) * grid[i][j]
                else:
                    max_dp[i][j] = min(min_dp[i-1][j], min_dp[i][j-1]) * grid[i][j]
                    min_dp[i][j] = max(max_dp[i-1][j], max_dp[i][j-1]) * grid[i][j]

        if max_dp[m-1][n-1] < 0:
            return -1
        else:
            return max_dp[m-1][n-1] % (10**9 + 7)