class Solution:
    def minCostToVisitAllPoints(self, prices: List[int], costs: List[int]) -> int:
        n = len(prices)
        dp = [0] * n
        for i in range(1, n):
            dp[i] = dp[i - 1] + abs(prices[i] - prices[i - 1]) * costs[i - 1]
        return dp[-1]