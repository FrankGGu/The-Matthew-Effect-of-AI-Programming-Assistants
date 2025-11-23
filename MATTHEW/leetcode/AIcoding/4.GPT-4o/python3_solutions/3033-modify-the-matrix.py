class Solution:
    def modifyMatrix(self, mat: List[List[int]]) -> List[List[int]]:
        rows, cols = len(mat), len(mat[0])
        result = [[1] * cols for _ in range(rows)]

        for r in range(rows):
            for c in range(cols):
                if mat[r][c] == 0:
                    for i in range(rows):
                        result[i][c] = 0
                    for j in range(cols):
                        result[r][j] = 0

        return result