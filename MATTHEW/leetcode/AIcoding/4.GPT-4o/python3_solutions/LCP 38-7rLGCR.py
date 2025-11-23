class Solution:
    def guardCastle(self, A: List[List[int]]) -> int:
        n, m = len(A), len(A[0])
        dp = [[0] * m for _ in range(n)]

        for i in range(n):
            for j in range(m):
                if A[i][j] == 1:
                    dp[i][j] = 1
                if i > 0:
                    dp[i][j] += dp[i-1][j]
                if j > 0:
                    dp[i][j] += dp[i][j-1]
                if i > 0 and j > 0:
                    dp[i][j] -= dp[i-1][j-1]

        total_guard = sum(dp[i][m-1] for i in range(n)) + sum(dp[n-1][j] for j in range(m)) - dp[n-1][m-1]

        return total_guard