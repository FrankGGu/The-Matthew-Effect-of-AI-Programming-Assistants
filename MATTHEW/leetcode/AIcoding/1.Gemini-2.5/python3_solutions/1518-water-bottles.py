class Solution:
    def numWaterBottles(self, numBottles: int, numExchange: int) -> int:
        total_drunk = 0
        empty_bottles = 0

        # Drink all initial bottles
        total_drunk += numBottles
        empty_bottles += numBottles

        # Exchange empty bottles for new full ones
        while empty_bottles >= numExchange:
            new_full_bottles = empty_bottles // numExchange
            total_drunk += new_full_bottles
            empty_bottles = (empty_bottles % numExchange) + new_full_bottles

        return total_drunk