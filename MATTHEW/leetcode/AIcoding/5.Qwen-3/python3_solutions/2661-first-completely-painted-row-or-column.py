class Solution:
    def firstCompletePaintedPosition(self, arr: List[int], mat: List[List[int]]) -> int:
        rows = len(mat)
        cols = len(mat[0])
        count = [0] * (rows * cols)
        pos = {}
        for i in range(rows):
            for j in range(cols):
                pos[mat[i][j]] = (i, j)
        for k in range(len(arr)):
            num = arr[k]
            i, j = pos[num]
            count[i * cols + j] += 1
            if count[i * cols + j] == cols:
                return k
            if count[i * cols + j] == rows:
                return k
        return -1