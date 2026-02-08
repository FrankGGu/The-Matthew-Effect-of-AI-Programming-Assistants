class Solution:
    def minCost(self, bouquet: List[int]) -> int:
        bouquet.sort()
        n = len(bouquet)
        return sum(bouquet[i] for i in range(n // 2, n))