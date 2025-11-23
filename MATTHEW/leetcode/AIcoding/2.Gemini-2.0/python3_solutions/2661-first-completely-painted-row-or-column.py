class Solution:
    def firstCompleteIndex(self, arr: List[int], mat: List[List[int]]) -> int:
        rows = len(mat)
        cols = len(mat[0])
        pos = {}
        for i in range(rows):
            for j in range(cols):
                pos[mat[i][j]] = (i, j)

        row_count = [0] * rows
        col_count = [0] * cols

        for i in range(len(arr)):
            r, c = pos[arr[i]]
            row_count[r] += 1
            col_count[c] += 1

            if row_count[r] == cols or col_count[c] == rows:
                return i

        return -1