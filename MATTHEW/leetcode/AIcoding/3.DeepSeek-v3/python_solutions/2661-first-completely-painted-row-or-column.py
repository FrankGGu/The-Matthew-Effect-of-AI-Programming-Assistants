class Solution:
    def firstCompleteIndex(self, arr: List[int], mat: List[List[int]]) -> int:
        m, n = len(mat), len(mat[0])
        pos = {}
        for i in range(m):
            for j in range(n):
                pos[mat[i][j]] = (i, j)

        row_counts = [0] * m
        col_counts = [0] * n

        for idx, num in enumerate(arr):
            i, j = pos[num]
            row_counts[i] += 1
            col_counts[j] += 1
            if row_counts[i] == n or col_counts[j] == m:
                return idx
        return -1