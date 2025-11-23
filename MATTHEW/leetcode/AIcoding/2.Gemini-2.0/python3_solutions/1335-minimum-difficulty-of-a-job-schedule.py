class Solution:
    def minDifficulty(self, jobDifficulty: list[int], d: int) -> int:
        n = len(jobDifficulty)
        if n < d:
            return -1

        dp = [[float('inf')] * (d + 1) for _ in range(n + 1)]
        dp[0][0] = 0

        for i in range(1, n + 1):
            for j in range(1, min(i, d) + 1):
                max_difficulty = 0
                for k in range(i - 1, j - 2, -1):
                    max_difficulty = max(max_difficulty, jobDifficulty[k])
                    dp[i][j] = min(dp[i][j], dp[k][j - 1] + max_difficulty)

        return dp[n][d]