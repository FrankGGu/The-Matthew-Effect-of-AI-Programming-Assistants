class Solution:
    def maxScore(self, A: List[List[int]]) -> int:
        m, n = len(A), len(A[0])
        dp = [[0] * n for _ in range(m)]
        dp[0][0] = A[0][0]

        for i in range(m):
            for j in range(n):
                if i > 0:
                    dp[i][j] = max(dp[i][j], dp[i-1][j] + A[i][j])
                if j > 0:
                    dp[i][j] = max(dp[i][j], dp[i][j-1] + A[i][j])

        return dp[m-1][n-1]