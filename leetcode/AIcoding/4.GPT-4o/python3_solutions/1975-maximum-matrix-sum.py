class Solution:
    def maximumMatrixSum(self, matrix: List[List[int]]) -> int:
        total_sum = 0
        min_val = float('inf')
        negative_count = 0

        for row in matrix:
            for value in row:
                if value < 0:
                    negative_count += 1
                total_sum += abs(value)
                min_val = min(min_val, abs(value))

        if negative_count % 2 == 0:
            return total_sum
        else:
            return total_sum - 2 * min_val