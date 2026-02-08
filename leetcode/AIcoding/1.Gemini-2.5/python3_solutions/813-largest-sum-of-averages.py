class Solution:
    def largestSumOfAverages(self, A: list[int], K: int) -> float:
        N = len(A)

        P = [0] * (N + 1)
        for i in range(N):
            P[i+1] = P[i] + A[i]

        dp = [[0.0] * (K + 1) for _ in range(N + 1)]

        for i in range(1, N + 1):
            dp[i][1] = P[i] / i

        for k in range(2, K + 1):
            for i in range(k, N + 1):
                for j in range(k - 1, i):
                    current_average = (P[i] - P[j]) / (i - j)
                    dp[i][k] = max(dp[i][k], dp[j][k-1] + current_average)

        return dp[N][K]