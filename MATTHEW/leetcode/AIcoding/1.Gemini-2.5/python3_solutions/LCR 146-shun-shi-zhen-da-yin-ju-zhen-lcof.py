class Solution:
    def spiralOrder(self, matrix: list[list[int]]) -> list[int]:
        result = []
        if not matrix or not matrix[0]:
            return result

        rows, cols = len(matrix), len(matrix[0])
        top, bottom = 0, rows - 1
        left, right = 0, cols - 1

        while top <= bottom and left <= right:
            # Traverse right
            for c in range(left, right + 1):
                result.append(matrix[top][c])
            top += 1
            if top > bottom:
                break

            # Traverse down
            for r in range(top, bottom + 1):
                result.append(matrix[r][right])
            right -= 1
            if left > right:
                break

            # Traverse left
            for c in range(right, left - 1, -1):
                result.append(matrix[bottom][c])
            bottom -= 1
            if top > bottom:
                break

            # Traverse up
            for r in range(bottom, top - 1, -1):
                result.append(matrix[r][left])
            left += 1
            if left > right:
                break

        return result