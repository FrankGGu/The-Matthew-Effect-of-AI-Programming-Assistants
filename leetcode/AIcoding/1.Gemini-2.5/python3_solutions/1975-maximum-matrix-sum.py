import math

class Solution:
    def maxMatrixSum(self, matrix: list[list[int]]) -> int:
        neg_count = 0
        total_abs_sum = 0
        min_abs_val = math.inf

        for row in matrix:
            for x in row:
                if x < 0:
                    neg_count += 1
                total_abs_sum += abs(x)
                min_abs_val = min(min_abs_val, abs(x))

        if neg_count % 2 == 0:
            return total_abs_sum
        else:
            return total_abs_sum - 2 * min_abs_val