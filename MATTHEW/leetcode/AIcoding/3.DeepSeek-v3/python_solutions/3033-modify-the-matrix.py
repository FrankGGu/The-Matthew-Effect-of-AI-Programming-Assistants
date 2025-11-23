class Solution:
    def modifiedMatrix(self, matrix: List[List[int]]) -> List[List[int]]:
        m = len(matrix)
        n = len(matrix[0])
        max_cols = [max(matrix[i][j] for i in range(m)) for j in range(n)]

        for i in range(m):
            for j in range(n):
                if matrix[i][j] == -1:
                    matrix[i][j] = max_cols[j]

        return matrix