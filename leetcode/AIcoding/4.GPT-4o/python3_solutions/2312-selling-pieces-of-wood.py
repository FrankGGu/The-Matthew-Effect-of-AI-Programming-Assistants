class Solution:
    def maxProfit(self, length: int, prices: List[int]) -> int:
        dp = [0] * (length + 1)
        for i in range(1, length + 1):
            for j in range(1, min(i, len(prices)) + 1):
                dp[i] = max(dp[i], prices[j - 1] + dp[i - j])
        return dp[length]