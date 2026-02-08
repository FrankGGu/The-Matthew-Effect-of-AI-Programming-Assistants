class Solution:
    def maxScore(self, grid: List[List[int]]) -> int:
        m, n = len(grid), len(grid[0])
        dp = [[-float('inf')] * n for _ in range(m)]
        max_score = -float('inf')

        for i in range(m-1, -1, -1):
            for j in range(n-1, -1, -1):
                if i == m - 1 and j == n - 1:
                    dp[i][j] = 0
                else:
                    if i + 1 < m:
                        dp[i][j] = max(dp[i][j], grid[i+1][j] - grid[i][j] + dp[i+1][j])
                    if j + 1 < n:
                        dp[i][j] = max(dp[i][j], grid[i][j+1] - grid[i][j] + dp[i][j+1])
                max_score = max(max_score, dp[i][j])

        return max_score