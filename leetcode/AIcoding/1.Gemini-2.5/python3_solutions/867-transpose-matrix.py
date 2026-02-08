class Solution:
    def transpose(self, matrix: list[list[int]]) -> list[list[int]]:
        rows = len(matrix)
        cols = len(matrix[0])

        transposed_matrix = [[0] * rows for _ in range(cols)]

        for r in range(rows):
            for c in range(cols):
                transposed_matrix[c][r] = matrix[r][c]

        return transposed_matrix