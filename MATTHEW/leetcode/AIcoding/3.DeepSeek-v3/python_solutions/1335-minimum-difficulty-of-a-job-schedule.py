class Solution:
    def minDifficulty(self, jobDifficulty: List[int], d: int) -> int:
        n = len(jobDifficulty)
        if n < d:
            return -1

        dp = [[float('inf')] * n for _ in range(d)]

        max_val = 0
        for i in range(n):
            max_val = max(max_val, jobDifficulty[i])
            dp[0][i] = max_val

        for day in range(1, d):
            for i in range(day, n):
                max_val = 0
                for j in range(i, day - 1, -1):
                    max_val = max(max_val, jobDifficulty[j])
                    dp[day][i] = min(dp[day][i], dp[day - 1][j - 1] + max_val)

        return dp[-1][-1] if dp[-1][-1] != float('inf') else -1