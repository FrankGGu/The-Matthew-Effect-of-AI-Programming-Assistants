class Solution:
    def firstCompleteIndex(self, arr: List[int], mat: List[List[int]]) -> int:
        n, m = len(mat), len(mat[0])
        pos = {}

        for i in range(n):
            for j in range(m):
                pos[mat[i][j]] = (i, j)

        row_count = [0] * n
        col_count = [0] * m

        for index, num in enumerate(arr):
            if num in pos:
                x, y = pos[num]
                row_count[x] += 1
                col_count[y] += 1

                if row_count[x] == m or col_count[y] == n:
                    return index

        return -1