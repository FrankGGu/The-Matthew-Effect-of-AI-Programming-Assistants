class Solution:
    def minimumDamage(self, A: List[int], B: List[int]) -> int:
        n = len(A)
        dp = [[float('inf')] * (n + 1) for _ in range(n + 1)]
        dp[0][0] = 0

        for i in range(n + 1):
            for j in range(n + 1):
                if i < n:
                    dp[i + 1][j] = min(dp[i + 1][j], dp[i][j])
                if j < n:
                    dp[i][j + 1] = min(dp[i][j + 1], dp[i][j])
                if i < n and j < n:
                    dp[i + 1][j + 1] = min(dp[i + 1][j + 1], dp[i][j] + max(0, A[i] - B[j]))

        return min(dp[n][j] for j in range(n + 1))