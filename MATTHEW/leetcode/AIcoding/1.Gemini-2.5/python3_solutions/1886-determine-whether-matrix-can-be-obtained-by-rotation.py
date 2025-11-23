class Solution:
    def findRotation(self, mat: list[list[int]], target: list[list[int]]) -> bool:
        n = len(mat)

        def rotate_90_clockwise(matrix):
            rotated = [[0] * n for _ in range(n)]
            for r in range(n):
                for c in range(n):
                    rotated[c][n - 1 - r] = matrix[r][c]
            return rotated

        for _ in range(4):
            if mat == target:
                return True
            mat = rotate_90_clockwise(mat)

        return False