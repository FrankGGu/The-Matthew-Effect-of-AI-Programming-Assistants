class Solution:
    def largestSumOfAverages(self, A: List[int], K: int) -> float:
        n = len(A)
        dp = [[0] * (K + 1) for _ in range(n + 1)]
        prefix_sum = [0] * (n + 1)

        for i in range(1, n + 1):
            prefix_sum[i] = prefix_sum[i - 1] + A[i - 1]

        for k in range(1, K + 1):
            for i in range(k, n + 1):
                for j in range(k - 1, i):
                    dp[i][k] = max(dp[i][k], dp[j][k - 1] + (prefix_sum[i] - prefix_sum[j]) / (i - j))

        return dp[n][K]