class Solution:
    def maxCoins(self, piles: List[int]) -> int:
        piles.sort()
        n = len(piles) // 3
        return sum(piles[i] for i in range(n, len(piles), 2))