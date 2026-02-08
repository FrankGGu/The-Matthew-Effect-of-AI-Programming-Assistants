import math

class Solution:
    def minDifficulty(self, jobDifficulty: list[int], d: int) -> int:
        n = len(jobDifficulty)

        if n < d:
            return -1

        dp = [[math.inf] * (d + 1) for _ in range(n + 1)]

        dp[0][0] = 0

        for k in range(1, d + 1):
            for i in range(k, n + 1):
                max_difficulty_last_day = 0
                for p_idx in range(i - 1, k - 2, -1):
                    max_difficulty_last_day = max(max_difficulty_last_day, jobDifficulty[p_idx])

                    if dp[p_idx][k - 1] == math.inf:
                        continue

                    dp[i][k] = min(dp[i][k], dp[p_idx][k - 1] + max_difficulty_last_day)

        return dp[n][d] if dp[n][d] != math.inf else -1