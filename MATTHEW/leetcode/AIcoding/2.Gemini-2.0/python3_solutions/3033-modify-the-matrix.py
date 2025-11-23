class Solution:
    def modifiedMatrix(self, matrix: List[List[int]]) -> List[List[int]]:
        n = len(matrix)
        m = len(matrix[0])

        max_vals = [-1] * m
        for j in range(m):
            for i in range(n):
                max_vals[j] = max(max_vals[j], matrix[i][j])

        for i in range(n):
            for j in range(m):
                if matrix[i][j] == -1:
                    matrix[i][j] = max_vals[j]

        return matrix