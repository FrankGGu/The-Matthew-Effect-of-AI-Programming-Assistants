class Solution:
    def findDiagonalOrder(self, matrix: List[List[int]]) -> List[int]:
        if not matrix or not matrix[0]:
            return []

        rows, cols = len(matrix), len(matrix[0])
        result = []
        row, col = 0, 0
        up = True

        for _ in range(rows * cols):
            result.append(matrix[row][col])

            if up:
                if row - 1 >= 0 and col + 1 < cols:
                    row -= 1
                    col += 1
                else:
                    if col + 1 < cols:
                        col += 1
                    else:
                        row += 1
                    up = False
            else:
                if row + 1 < rows and col - 1 >= 0:
                    row += 1
                    col -= 1
                else:
                    if row + 1 < rows:
                        row += 1
                    else:
                        col += 1
                    up = True

        return result