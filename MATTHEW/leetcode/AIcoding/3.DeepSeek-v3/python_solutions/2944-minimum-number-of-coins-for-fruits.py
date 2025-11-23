class Solution:
    def minimumCoins(self, prices: List[int]) -> int:
        n = len(prices)
        dp = [0] * (n + 2)
        for i in range(n - 1, -1, -1):
            min_cost = float('inf')
            for j in range(i + 1, min(i + 2 + 1, n + 1)):
                min_cost = min(min_cost, dp[j])
            dp[i] = prices[i] + min_cost
        return dp[0]