import math

class Solution:
    def maximumProfit(self, prices: list[int], discounts: list[int]) -> int:
        min_effective_buy_cost = math.inf
        max_profit = 0

        for i in range(len(prices)):
            max_profit = max(max_profit, prices[i] - min_effective_buy_cost)

            current_effective_buy_cost = prices[i] - discounts[i]
            min_effective_buy_cost = min(min_effective_buy_cost, current_effective_buy_cost)

        return max_profit