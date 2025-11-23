class Solution:
    def maxProfit(self, prices: list[int], fee: int) -> int:
        n = len(prices)
        if n < 2:
            return 0

        hold = -prices[0]
        not_hold = 0

        for i in range(1, n):
            prev_hold = hold
            hold = max(hold, not_hold - prices[i])
            not_hold = max(not_hold, prev_hold + prices[i] - fee)

        return not_hold