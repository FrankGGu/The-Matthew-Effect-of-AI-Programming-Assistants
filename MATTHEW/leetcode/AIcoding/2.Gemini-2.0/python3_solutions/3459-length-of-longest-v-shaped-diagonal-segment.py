class Solution:
    def solve(self, matrix):
        n = len(matrix)
        m = len(matrix[0])
        max_len = 0
        for i in range(n):
            for j in range(m):
                for k in range(1, min(n - i, m - j) + 1):
                    len1 = k
                    for l in range(1, min(i + 1, m - j - k + 1) + 1):
                        len2 = l
                        if matrix[i][j] > matrix[i + k - 1][j + k - 1] and matrix[i + k - 1][j + k - 1] < matrix[i - l + k][j + k + l - 2]:
                            max_len = max(max_len, len1 + len2 - 1)
        return max_len
    def longestVShape(self, matrix: List[List[int]]) -> int:
        return self.solve(matrix)