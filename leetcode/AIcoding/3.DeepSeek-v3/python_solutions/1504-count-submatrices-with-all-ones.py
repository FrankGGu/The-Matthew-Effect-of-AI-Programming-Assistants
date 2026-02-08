class Solution:
    def numSubmat(self, mat: List[List[int]]) -> int:
        m, n = len(mat), len(mat[0])
        res = 0

        for i in range(m):
            for j in range(n):
                if mat[i][j] == 0:
                    continue
                min_width = float('inf')
                for k in range(i, -1, -1):
                    if mat[k][j] == 0:
                        break
                    width = 0
                    while j + width < n and mat[k][j + width] == 1:
                        width += 1
                    min_width = min(min_width, width)
                    res += min_width
        return res