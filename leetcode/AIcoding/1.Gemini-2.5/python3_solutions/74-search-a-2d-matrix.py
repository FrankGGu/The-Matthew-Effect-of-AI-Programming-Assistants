class Solution:
    def searchMatrix(self, matrix: list[list[int]], target: int) -> bool:
        if not matrix or not matrix[0]:
            return False

        m = len(matrix)
        n = len(matrix[0])

        low = 0
        high = m * n - 1

        while low <= high:
            mid = low + (high - low) // 2

            row = mid // n
            col = mid % n

            val = matrix[row][col]

            if val == target:
                return True
            elif val < target:
                low = mid + 1
            else:
                high = mid - 1

        return False