class Solution:
    def buyChocolates(self, prices: list[int], money: int) -> int:
        prices.sort()
        min_cost_two = prices[0] + prices[1]
        if money >= min_cost_two:
            return money - min_cost_two
        else:
            return money