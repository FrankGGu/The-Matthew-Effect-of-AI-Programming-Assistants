from typing import List

class Solution:
    def spiralOrder(self, matrix: List[List[int]]) -> List[int]:
        res = []
        if not matrix or not matrix[0]:
            return res

        rows = len(matrix)
        cols = len(matrix[0])

        top = 0
        bottom = rows - 1
        left = 0
        right = cols - 1

        while top <= bottom and left <= right:
            # Traverse right
            for c in range(left, right + 1):
                res.append(matrix[top][c])
            top += 1

            # Traverse down
            for r in range(top, bottom + 1):
                res.append(matrix[r][right])
            right -= 1

            # Check if there are still rows to traverse
            if top <= bottom:
                # Traverse left
                for c in range(right, left - 1, -1):
                    res.append(matrix[bottom][c])
                bottom -= 1

            # Check if there are still columns to traverse
            if left <= right:
                # Traverse up
                for r in range(bottom, top - 1, -1):
                    res.append(matrix[r][left])
                left += 1

        return res