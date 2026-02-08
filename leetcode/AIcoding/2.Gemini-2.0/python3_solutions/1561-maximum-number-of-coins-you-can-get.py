class Solution:
    def maxCoins(self, piles: list[int]) -> int:
        piles.sort()
        res = 0
        l, r = 0, len(piles) - 2
        while l <= r:
            res += piles[r]
            l += 1
            r -= 2
        return res