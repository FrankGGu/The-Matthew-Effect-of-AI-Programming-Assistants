class Solution:
    def minCost(self, homePos: List[int], rowCosts: List[int], colCosts: List[int]) -> int:
        start_row, start_col = 0, 0
        home_row, home_col = homePos

        total_cost = 0

        if home_row > start_row:
            for r in range(start_row + 1, home_row + 1):
                total_cost += rowCosts[r]
        elif home_row < start_row:
            for r in range(start_row - 1, home_row - 1, -1):
                total_cost += rowCosts[r]

        if home_col > start_col:
            for c in range(start_col + 1, home_col + 1):
                total_cost += colCosts[c]
        elif home_col < start_col:
            for c in range(start_col - 1, home_col - 1, -1):
                total_cost += colCosts[c]

        return total_cost