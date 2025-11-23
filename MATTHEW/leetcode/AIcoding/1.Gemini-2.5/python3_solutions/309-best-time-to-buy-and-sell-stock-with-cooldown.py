class Solution:
    def maxProfit(self, prices: list[int]) -> int:
        n = len(prices)
        if n == 0:
            return 0

        # buy: maximum profit if we currently hold a stock.
        #      This means we either bought today or held a stock from yesterday.
        # sell: maximum profit if we just sold a stock today.
        #       This means we cannot buy tomorrow (cooldown).
        # rest: maximum profit if we are in a rest state (not holding a stock, and not just sold).
        #       This means we either rested yesterday or completed a cooldown from a sale two days ago.

        # Initialize states for day -1 (before any transactions)
        # It's impossible to hold a stock or have sold one before day 0, so profit is negative infinity.
        # Resting yields 0 profit.
        buy = -float('inf')
        sell = -float('inf')
        rest = 0

        for price in prices:
            # Store previous day's states to calculate current day's states
            prev_buy = buy
            prev_sell = sell
            prev_rest = rest

            # Calculate current day's 'buy' state:
            # 1. Continue holding the stock from yesterday (prev_buy).
            # 2. Buy today after having rested yesterday (prev_rest - price).
            buy = max(prev_buy, prev_rest - price)

            # Calculate current day's 'sell' state:
            # 1. Sell the stock held from yesterday (prev_buy + price).
            sell = prev_buy + price

            # Calculate current day's 'rest' state:
            # 1. Continue resting from yesterday (prev_rest).
            # 2. Transition from a 'sell' state yesterday to a 'rest' state today (cooldown) (prev_sell).
            rest = max(prev_rest, prev_sell)

        # The maximum profit must come from either selling on the last day or being in a rest state.
        # Holding a stock (buy state) at the end does not represent a realized profit.
        return max(sell, rest)