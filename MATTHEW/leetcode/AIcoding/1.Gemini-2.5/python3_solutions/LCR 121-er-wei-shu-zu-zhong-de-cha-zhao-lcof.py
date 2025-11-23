class Solution:
    def searchMatrix(self, matrix: list[list[int]], target: int) -> bool:
        if not matrix or not matrix[0]:
            return False

        m = len(matrix)
        n = len(matrix[0])

        row = 0
        col = n - 1

        while row < m and col >= 0:
            current_val = matrix[row][col]
            if current_val == target:
                return True
            elif current_val < target:
                row += 1
            else:
                col -= 1

        return False