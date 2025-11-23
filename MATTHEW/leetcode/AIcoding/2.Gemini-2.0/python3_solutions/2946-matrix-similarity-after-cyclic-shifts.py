class Solution:
    def areSimilar(self, mat: List[List[int]], k: int) -> bool:
        m, n = len(mat), len(mat[0])
        k %= n
        for i in range(m):
            shifted_row = mat[i][n - k:] + mat[i][:n - k] if i % 2 == 0 else mat[i][k:] + mat[i][:k]
            if shifted_row != mat[i]:
                return False
        return True