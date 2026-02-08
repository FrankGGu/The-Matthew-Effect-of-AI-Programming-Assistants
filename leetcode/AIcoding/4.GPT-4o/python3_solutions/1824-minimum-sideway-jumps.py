class Solution:
    def minSideJumps(self, obstacles: List[int]) -> int:
        n = len(obstacles)
        dp = [[float('inf')] * 3 for _ in range(n)]
        dp[0][0] = dp[0][1] = dp[0][2] = 0

        for i in range(n):
            for j in range(3):
                if obstacles[i] != j + 1:
                    dp[i][j] = min(dp[i][j], dp[i - 1][j])
                    if j > 0:
                        dp[i][j] = min(dp[i][j], dp[i][j - 1] + 1)
                    if j < 2:
                        dp[i][j] = min(dp[i][j], dp[i][j + 1] + 1)

        return min(dp[n - 1])