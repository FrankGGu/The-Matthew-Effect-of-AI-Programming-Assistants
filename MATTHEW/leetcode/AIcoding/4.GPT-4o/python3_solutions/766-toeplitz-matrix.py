class Solution:
    def isToeplitzMatrix(self, matrix: List[List[int]]) -> bool:
        rows, cols = len(matrix), len(matrix[0])
        for r in range(rows):
            for c in range(cols):
                if r > 0 and c > 0 and matrix[r][c] != matrix[r - 1][c - 1]:
                    return False
        return True