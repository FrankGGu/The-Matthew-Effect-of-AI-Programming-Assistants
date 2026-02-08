import math

class Solution:
    def maxProfit(self, k: int, prices: list[int]) -> int:
        n = len(prices)

        # If k is very large, it's equivalent to unlimited transactions.
        # This occurs when k >= n // 2, because you can at most perform n // 2 transactions
        # (buy on day 0, sell on day 1, buy on day 2, sell on day 3, etc.).
        if k >= n // 2:
            max_profit = 0
            for i in range(1, n):
                if prices[i] > prices[i-1]:
                    max_profit += prices[i] - prices[i-1]
            return max_profit

        # DP approach for limited transactions
        # buy[i] stores the maximum profit after i transactions, ending with a buy (holding a stock)
        # sell[i] stores the maximum profit after i transactions, ending with a sell (not holding a stock)

        # Initialize with negative infinity for buy states, as we start with no stock
        # and 0 profit for sell states (0 transactions, 0 profit, no stock)
        buy = [-math.inf] * (k + 1)
        sell = [0] * (k + 1)

        for price in prices:
            # Iterate from k down to 1 to ensure that sell[i-1] refers to the state
            # before the current transaction's buy, and buy[i] refers to the state
            # before the current transaction's sell.
            for i in range(1, k + 1):
                # Option 1: Do nothing (keep current buy[i] profit)
                # Option 2: Buy a stock using the i-th transaction.
                #           This means we must have completed i-1 transactions and not be holding a stock.
                buy[i] = max(buy[i], sell[i-1] - price)

                # Option 1: Do nothing (keep current sell[i] profit)
                # Option 2: Sell a stock, completing the i-th transaction.
                #           This means we must have bought a stock as part of the i-th transaction.
                sell[i] = max(sell[i], buy[i] + price)

        # The maximum profit will be the maximum value in the sell array,
        # as we want to end with no stock.
        return max(sell)