class Solution:
    def minDifficulty(self, jobDifficulty: List[int], d: int) -> int:
        n = len(jobDifficulty)
        if n < d:
            return -1

        dp = [[float('inf')] * (d + 1) for _ in range(n + 1)]
        dp[0][0] = 0

        for j in range(1, d + 1):
            for i in range(j, n + 1):
                max_job = 0
                for k in range(i - 1, j - 2, -1):
                    max_job = max(max_job, jobDifficulty[k])
                    dp[i][j] = min(dp[i][j], dp[k][j - 1] + max_job)

        return dp[n][d]