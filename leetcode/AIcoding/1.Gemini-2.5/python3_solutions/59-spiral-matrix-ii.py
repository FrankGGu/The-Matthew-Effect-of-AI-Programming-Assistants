class Solution:
    def generateMatrix(self, n: int) -> list[list[int]]:
        matrix = [[0] * n for _ in range(n)]

        num = 1
        top, bottom = 0, n - 1
        left, right = 0, n - 1

        while top <= bottom and left <= right:
            # Traverse right
            for c in range(left, right + 1):
                matrix[top][c] = num
                num += 1
            top += 1

            # Traverse down
            for r in range(top, bottom + 1):
                matrix[r][right] = num
                num += 1
            right -= 1

            # Traverse left (only if there's a row to traverse)
            if top <= bottom:
                for c in range(right, left - 1, -1):
                    matrix[bottom][c] = num
                    num += 1
                bottom -= 1

            # Traverse up (only if there's a column to traverse)
            if left <= right:
                for r in range(bottom, top - 1, -1):
                    matrix[r][left] = num
                    num += 1
                left += 1

        return matrix