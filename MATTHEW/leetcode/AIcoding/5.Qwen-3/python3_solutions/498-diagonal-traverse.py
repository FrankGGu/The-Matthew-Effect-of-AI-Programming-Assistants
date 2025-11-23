class Solution:
    def findDiagonalOrder(self, matrix: List[List[int]]) -> List[int]:
        if not matrix or not matrix[0]:
            return []

        rows = len(matrix)
        cols = len(matrix[0])
        result = []
        row, col = 0, 0
        direction = 1

        while len(result) < rows * cols:
            result.append(matrix[row][col])
            if direction == 1:
                if row == 0 and col == cols - 1:
                    direction = -1
                    row += 1
                elif col == cols - 1:
                    direction = -1
                    row += 1
                elif row == 0:
                    direction = -1
                    col += 1
                else:
                    row -= 1
                    col += 1
            else:
                if col == 0 and row == rows - 1:
                    direction = 1
                    col += 1
                elif row == rows - 1:
                    direction = 1
                    col += 1
                elif col == 0:
                    direction = 1
                    row += 1
                else:
                    row += 1
                    col -= 1

        return result