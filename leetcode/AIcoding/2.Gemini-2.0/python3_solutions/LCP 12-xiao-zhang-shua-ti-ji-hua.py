class Solution:
    def minDifficulty(self, jobDifficulty: List[int], d: int) -> int:
        n = len(jobDifficulty)
        if n < d:
            return -1

        dp = [[float('inf')] * (n + 1) for _ in range(d + 1)]
        dp[0][0] = 0

        for i in range(1, d + 1):
            for j in range(i, n + 1):
                max_difficulty = 0
                for k in range(j - 1, i - 2, -1):
                    max_difficulty = max(max_difficulty, jobDifficulty[k])
                    dp[i][j] = min(dp[i][j], dp[i - 1][k] + max_difficulty)

        return dp[d][n]