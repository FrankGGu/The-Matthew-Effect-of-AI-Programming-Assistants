class Solution:
    def numSubmatrixSumTarget(self, matrix: List[List[int]], target: int) -> int:
        rows = len(matrix)
        cols = len(matrix[0])
        count = 0

        for i in range(rows):
            for j in range(1, cols):
                matrix[i][j] += matrix[i][j - 1]

        for c1 in range(cols):
            for c2 in range(c1, cols):
                prefix_sum = {0: 1}
                curr_sum = 0
                for r in range(rows):
                    curr_sum += (matrix[r][c2] - (matrix[r][c1 - 1] if c1 > 0 else 0))
                    if curr_sum - target in prefix_sum:
                        count += prefix_sum[curr_sum - target]
                    if curr_sum in prefix_sum:
                        prefix_sum[curr_sum] += 1
                    else:
                        prefix_sum[curr_sum] = 1

        return count