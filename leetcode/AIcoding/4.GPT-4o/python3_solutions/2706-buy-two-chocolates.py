class Solution:
    def buyChoco(self, prices: List[int], money: int) -> int:
        prices.sort()
        if len(prices) < 2:
            return money
        total_cost = prices[0] + prices[1]
        return money - total_cost if total_cost <= money else money