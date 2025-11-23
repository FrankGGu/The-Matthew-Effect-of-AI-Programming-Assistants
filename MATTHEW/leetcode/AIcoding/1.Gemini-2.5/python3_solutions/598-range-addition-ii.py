class Solution:
    def maxCount(self, m: int, n: int, ops: list[list[int]]) -> int:
        min_row = m
        min_col = n

        for op_row, op_col in ops:
            min_row = min(min_row, op_row)
            min_col = min(min_col, op_col)

        return min_row * min_col