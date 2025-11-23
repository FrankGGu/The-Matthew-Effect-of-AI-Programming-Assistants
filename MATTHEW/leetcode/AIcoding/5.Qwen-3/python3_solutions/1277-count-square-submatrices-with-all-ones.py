class Solution:
    def countSquares(self, matrix: List[List[int]]) -> int:
        m = len(matrix)
        n = len(matrix[0])
        count = 0
        for i in range(m):
            for j in range(n):
                if matrix[i][j] == 1:
                    if i == 0 or j == 0:
                        count += 1
                    else:
                        min_val = min(matrix[i-1][j-1], matrix[i-1][j], matrix[i][j-1])
                        matrix[i][j] = min_val + 1
                        count += matrix[i][j]
        return count