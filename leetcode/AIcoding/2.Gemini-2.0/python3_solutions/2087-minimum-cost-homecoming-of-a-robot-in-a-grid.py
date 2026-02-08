class Solution:
    def minCost(self, startPos: List[int], homePos: List[int], rowCosts: List[int], colCosts: List[int]) -> int:
        row_start, col_start = startPos
        row_home, col_home = homePos

        row_cost = 0
        if row_start < row_home:
            for i in range(row_start + 1, row_home + 1):
                row_cost += rowCosts[i]
        elif row_start > row_home:
            for i in range(row_start - 1, row_home - 1, -1):
                row_cost += rowCosts[i]

        col_cost = 0
        if col_start < col_home:
            for i in range(col_start + 1, col_home + 1):
                col_cost += colCosts[i]
        elif col_start > col_home:
            for i in range(col_start - 1, col_home - 1, -1):
                col_cost += colCosts[i]

        return row_cost + col_cost