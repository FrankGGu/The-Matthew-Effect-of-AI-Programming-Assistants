class Solution:
    def maxBottlesDrunk(self, numBottles: int, numExchange: int, extraBottles: int) -> int:
        total_drunk_bottles = numBottles
        empty_bottles = numBottles

        # Determine the effective number of new bottles obtained per exchange.
        # We have two options for numExchange empty bottles:
        # 1. Standard exchange: get 1 full bottle.
        # 2. Special offer: get extraBottles full bottles.
        # To maximize drunk bottles, we always choose the option that yields more full bottles.
        # If extraBottles is 0, we still get 1 bottle from the standard exchange.
        # If extraBottles is 1, it's the same as the standard exchange.
        # If extraBottles > 1, it's better than the standard exchange.
        # So, the number of new full bottles obtained for each numExchange empty bottles is max(1, extraBottles).
        new_bottles_per_exchange = max(1, extraBottles)

        # Continue exchanging as long as we have enough empty bottles
        while empty_bottles >= numExchange:
            # Calculate how many sets of numExchange empty bottles we have
            num_exchanges_possible = empty_bottles // numExchange

            # Calculate how many new full bottles are obtained from these exchanges
            new_full_bottles = num_exchanges_possible * new_bottles_per_exchange

            # Add these new bottles to the total count of drunk bottles
            total_drunk_bottles += new_full_bottles

            # Update the count of empty bottles:
            # 1. Subtract the empty bottles used for the exchanges.
            #    This is equivalent to keeping only the remainder after division.
            empty_bottles = empty_bottles % numExchange

            # 2. Add the newly emptied bottles (from drinking the new_full_bottles).
            empty_bottles += new_full_bottles

        return total_drunk_bottles