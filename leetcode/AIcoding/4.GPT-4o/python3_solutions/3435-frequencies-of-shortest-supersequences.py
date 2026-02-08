class Solution:
    def shortestSupersequence(self, A: str, B: str) -> List[int]:
        from collections import defaultdict

        m, n = len(A), len(B)
        dp = [[float('inf')] * (n + 1) for _ in range(m + 1)]
        dp[0][0] = 0

        for i in range(1, m + 1):
            dp[i][0] = i

        for j in range(1, n + 1):
            dp[0][j] = j

        for i in range(1, m + 1):
            for j in range(1, n + 1):
                if A[i - 1] == B[j - 1]:
                    dp[i][j] = dp[i - 1][j - 1]
                dp[i][j] = min(dp[i][j], dp[i - 1][j] + 1, dp[i][j - 1] + 1)

        min_length = float('inf')
        count = 0

        for i in range(m + 1):
            for j in range(n + 1):
                if dp[i][j] == min_length:
                    count += 1
                elif dp[i][j] < min_length:
                    min_length = dp[i][j]
                    count = 1

        return count