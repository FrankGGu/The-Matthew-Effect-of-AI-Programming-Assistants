class Solution:
    def matrixBlockSum(self, mat, K):
        m, n = len(mat), len(mat[0])
        dp = [[0] * (n + 1) for _ in range(m + 1)]
        for i in range(m):
            for j in range(n):
                dp[i + 1][j + 1] = mat[i][j] + dp[i][j + 1] + dp[i + 1][j] - dp[i][j]
        res = [[0] * n for _ in range(m)]
        for i in range(m):
            for j in range(n):
                x1, y1 = max(0, i - K), max(0, j - K)
                x2, y2 = min(m - 1, i + K), min(n - 1, j + K)
                res[i][j] = dp[x2 + 1][y2 + 1] - dp[x1][y2 + 1] - dp[x2 + 1][y1] + dp[x1][y1]
        return res