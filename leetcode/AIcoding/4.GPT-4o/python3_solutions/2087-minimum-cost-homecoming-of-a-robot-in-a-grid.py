class Solution:
    def minCost(self, startPos: List[int], homePos: List[int], rowCosts: List[int], colCosts: List[int]) -> int:
        r1, c1 = startPos
        r2, c2 = homePos
        total_cost = 0

        if r1 <= r2:
            for r in range(r1, r2 + 1):
                total_cost += rowCosts[r]
        else:
            for r in range(r1, r2 - 1, -1):
                total_cost += rowCosts[r]

        if c1 <= c2:
            for c in range(c1, c2 + 1):
                total_cost += colCosts[c]
        else:
            for c in range(c1, c2 - 1, -1):
                total_cost += colCosts[c]

        return total_cost