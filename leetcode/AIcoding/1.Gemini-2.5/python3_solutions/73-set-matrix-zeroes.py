class Solution:
    def setZeroes(self, matrix: list[list[int]]) -> None:
        """
        Do not return anything, modify matrix in-place instead.
        """
        m = len(matrix)
        n = len(matrix[0])

        row_0_has_zero = False
        col_0_has_zero = False

        for j in range(n):
            if matrix[0][j] == 0:
                row_0_has_zero = True
                break

        for i in range(m):
            if matrix[i][0] == 0:
                col_0_has_zero = True
                break

        for i in range(1, m):
            for j in range(1, n):
                if matrix[i][j] == 0:
                    matrix[i][0] = 0
                    matrix[0][j] = 0

        for i in range(1, m):
            for j in range(1, n):
                if matrix[i][0] == 0 or matrix[0][j] == 0:
                    matrix[i][j] = 0

        if row_0_has_zero:
            for j in range(n):
                matrix[0][j] = 0

        if col_0_has_zero:
            for i in range(m):
                matrix[i][0] = 0