class Solution:
    def maxProfit(self, prices: list[int]) -> int:
        if not prices:
            return 0

        # s0: max profit after 0 transactions (always 0)
        # b1: max profit if we are holding the 1st stock (bought it)
        # s1: max profit if we have sold the 1st stock
        # b2: max profit if we are holding the 2nd stock (bought it after selling 1st)
        # s2: max profit if we have sold the 2nd stock (completed 2 transactions)

        # Initialize states
        # s0 is implicitly 0
        b1 = float('-inf') # Max profit if we just bought the first stock
        s1 = 0             # Max profit if we just sold the first stock
        b2 = float('-inf') # Max profit if we just bought the second stock
        s2 = 0             # Max profit if we just sold the second stock

        for price in prices:
            # Update s2 (max profit after selling 2nd stock)
            # Option 1: Do nothing, keep previous s2
            # Option 2: Sell the 2nd stock we are holding (b2_prev + price)
            s2 = max(s2, b2 + price)

            # Update b2 (max profit after buying 2nd stock)
            # Option 1: Do nothing, keep previous b2
            # Option 2: Buy the 2nd stock using profit from s1 (s1_prev - price)
            b2 = max(b2, s1 - price)

            # Update s1 (max profit after selling 1st stock)
            # Option 1: Do nothing, keep previous s1
            # Option 2: Sell the 1st stock we are holding (b1_prev + price)
            s1 = max(s1, b1 + price)

            # Update b1 (max profit after buying 1st stock)
            # Option 1: Do nothing, keep previous b1
            # Option 2: Buy the 1st stock (0 - price, assuming initial capital is 0)
            b1 = max(b1, -price)

        return s2