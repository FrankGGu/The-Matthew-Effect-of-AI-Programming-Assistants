class Solution:
    def maxMatrixSum(self, matrix: List[List[int]]) -> int:
        neg_count = 0
        total_sum = 0
        min_abs = float('inf')

        for row in matrix:
            for num in row:
                if num < 0:
                    neg_count += 1
                total_sum += abs(num)
                min_abs = min(min_abs, abs(num))

        if neg_count % 2 == 0:
            return total_sum
        else:
            return total_sum - 2 * min_abs