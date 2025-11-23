class Solution:
    def trainingPlan(self, n: int, days: int, change: List[int]) -> int:
        dp = [[0] * (days + 1) for _ in range(n + 1)]

        for i in range(1, n + 1):
            for j in range(1, days + 1):
                dp[i][j] = dp[i][j - 1]
                if j >= i:
                    dp[i][j] = max(dp[i][j], dp[i - 1][j - i] + change[i - 1])

        return dp[n][days]