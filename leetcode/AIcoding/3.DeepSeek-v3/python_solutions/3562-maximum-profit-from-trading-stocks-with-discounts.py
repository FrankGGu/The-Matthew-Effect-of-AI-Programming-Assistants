class Solution:
    def maxProfit(self, prices: List[int], discounts: List[int]) -> int:
        n = len(prices)
        m = len(discounts)
        dp = [[0] * (m + 1) for _ in range(n + 1)]

        for i in range(1, n + 1):
            for j in range(1, m + 1):
                if discounts[j - 1] >= prices[i - 1]:
                    dp[i][j] = max(dp[i - 1][j - 1] + prices[i - 1] - discounts[j - 1], dp[i - 1][j], dp[i][j - 1])
                else:
                    dp[i][j] = max(dp[i - 1][j], dp[i][j - 1])

        return dp[n][m]