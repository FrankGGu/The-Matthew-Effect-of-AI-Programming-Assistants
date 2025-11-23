from typing import List

class Solution:
    def maxCoins(self, piles: List[int]) -> int:
        piles.sort()
        n = len(piles) // 3
        my_coins = 0

        for i in range(len(piles) - 2, n - 1, -2):
            my_coins += piles[i]

        return my_coins