class Solution:
    def maxValueOfCoins(self, piles: List[List[int]], k: int) -> int:
        n = len(piles)
        dp = [[0] * (k + 1) for _ in range(n + 1)]

        for i in range(1, n + 1):
            for j in range(1, k + 1):
                current_sum = 0
                dp[i][j] = dp[i - 1][j]
                for x in range(min(j, len(piles[i - 1]))):
                    current_sum += piles[i - 1][x]
                    dp[i][j] = max(dp[i][j], dp[i - 1][j - (x + 1)] + current_sum)

        return dp[n][k]