class Solution:
    def numSubmatrixSumTarget(self, matrix: List[List[int]], target: int) -> int:
        rows, cols = len(matrix), len(matrix[0])
        for r in range(rows):
            for c in range(1, cols):
                matrix[r][c] += matrix[r][c-1]
        result = 0
        for c1 in range(cols):
            for c2 in range(c1, cols):
                sum_map = {0: 1}
                current_sum = 0
                for r in range(rows):
                    current_sum += matrix[r][c2] - (matrix[r][c1-1] if c1 > 0 else 0)
                    result += sum_map.get(current_sum - target, 0)
                    sum_map[current_sum] = sum_map.get(current_sum, 0) + 1
        return result