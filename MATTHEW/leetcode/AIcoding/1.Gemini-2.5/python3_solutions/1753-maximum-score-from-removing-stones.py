import heapq

class Solution:
    def maximumScore(self, a: int, b: int, c: int) -> int:
        piles = sorted([a, b, c])

        if piles[2] <= piles[0] + piles[1]:
            return (piles[0] + piles[1] + piles[2]) // 2
        else:
            return piles[0] + piles[1]