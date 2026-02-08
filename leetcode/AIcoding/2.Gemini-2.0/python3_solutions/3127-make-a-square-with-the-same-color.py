class Solution:
    def solve(self, matrix: list[list[int]]) -> int:
        n = len(matrix)
        count = 0
        for i in range(n - 1):
            for j in range(n - 1):
                color = matrix[i][j]
                if (matrix[i][j + 1] == color and
                    matrix[i + 1][j] == color and
                    matrix[i + 1][j + 1] == color):
                    count += 1
        return count