class Solution:
    def modifyMatrix(self, matrix: list[list[int]]) -> list[list[int]]:
        m = len(matrix)
        n = len(matrix[0])

        col_maxes = [0] * n

        for j in range(n):
            current_col_max = 0
            for i in range(m):
                if matrix[i][j] != -1:
                    current_col_max = max(current_col_max, matrix[i][j])
            col_maxes[j] = current_col_max

        for i in range(m):
            for j in range(n):
                if matrix[i][j] == -1:
                    matrix[i][j] = col_maxes[j]

        return matrix