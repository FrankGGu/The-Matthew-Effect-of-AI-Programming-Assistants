class Solution:
    def minCost(self, startPos: list[int], homePos: list[int], rowCosts: list[int], colCosts: list[int]) -> int:
        sr, sc = startPos
        hr, hc = homePos

        total_cost = 0

        # Calculate row costs
        if sr < hr:
            for r in range(sr + 1, hr + 1):
                total_cost += rowCosts[r]
        elif sr > hr:
            for r in range(sr - 1, hr - 1, -1):
                total_cost += rowCosts[r]

        # Calculate column costs
        if sc < hc:
            for c in range(sc + 1, hc + 1):
                total_cost += colCosts[c]
        elif sc > hc:
            for c in range(sc - 1, hc - 1, -1):
                total_cost += colCosts[c]

        return total_cost