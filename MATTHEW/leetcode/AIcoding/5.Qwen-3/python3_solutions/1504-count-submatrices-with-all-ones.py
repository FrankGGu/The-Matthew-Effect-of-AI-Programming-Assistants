class Solution:
    def numSubmat(self, mat: List[List[int]]) -> int:
        m, n = len(mat), len(mat[0])
        for i in range(m):
            for j in range(1, n):
                if mat[i][j] == 1:
                    mat[i][j] += mat[i][j - 1]
        res = 0
        for j in range(n):
            for i in range(m):
                if mat[i][j] == 0:
                    continue
                min_width = mat[i][j]
                res += min_width
                k = i - 1
                while k >= 0 and mat[k][j] > 0:
                    min_width = min(min_width, mat[k][j])
                    res += min_width
                    k -= 1
        return res