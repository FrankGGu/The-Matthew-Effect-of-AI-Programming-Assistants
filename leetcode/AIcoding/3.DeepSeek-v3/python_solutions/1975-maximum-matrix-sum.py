class Solution:
    def maxMatrixSum(self, matrix: List[List[int]]) -> int:
        n = len(matrix)
        min_abs = float('inf')
        count_neg = 0
        total_sum = 0

        for i in range(n):
            for j in range(n):
                val = matrix[i][j]
                total_sum += abs(val)
                if val < 0:
                    count_neg += 1
                if abs(val) < min_abs:
                    min_abs = abs(val)

        if count_neg % 2 == 0:
            return total_sum
        else:
            return total_sum - 2 * min_abs