class Solution:
    def restoreMatrix(self, rowSum: list[int], colSum: list[int]) -> list[list[int]]:
        num_rows = len(rowSum)
        num_cols = len(colSum)

        matrix = [[0] * num_cols for _ in range(num_rows)]

        for r in range(num_rows):
            for c in range(num_cols):
                val = min(rowSum[r], colSum[c])
                matrix[r][c] = val
                rowSum[r] -= val
                colSum[c] -= val

        return matrix