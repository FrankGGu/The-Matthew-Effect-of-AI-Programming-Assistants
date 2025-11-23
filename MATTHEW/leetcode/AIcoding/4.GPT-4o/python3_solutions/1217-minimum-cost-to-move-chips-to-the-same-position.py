class Solution:
    def minCostToMoveChips(self, position: List[int]) -> int:
        odd_count = sum(1 for p in position if p % 2 != 0)
        return min(odd_count, len(position) - odd_count)