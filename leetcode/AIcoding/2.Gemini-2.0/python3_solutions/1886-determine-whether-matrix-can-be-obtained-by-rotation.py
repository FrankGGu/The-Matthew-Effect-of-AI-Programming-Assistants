class Solution:
    def findRotation(self, mat: list[list[int]], target: list[list[int]]) -> bool:
        def rotate(matrix):
            n = len(matrix)
            new_matrix = [[0] * n for _ in range(n)]
            for i in range(n):
                for j in range(n):
                    new_matrix[j][n - 1 - i] = matrix[i][j]
            return new_matrix

        if mat == target:
            return True

        for _ in range(3):
            mat = rotate(mat)
            if mat == target:
                return True

        return False