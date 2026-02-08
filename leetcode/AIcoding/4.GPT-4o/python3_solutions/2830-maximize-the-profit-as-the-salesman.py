class Solution:
    def maximizeProfit(self, n: int, prices: List[int], quantity: List[int]) -> int:
        dp = [0] * (n + 1)
        for i in range(len(prices)):
            for j in range(n, quantity[i] - 1, -1):
                dp[j] = max(dp[j], dp[j - quantity[i]] + prices[i] * quantity[i])
        return dp[n]