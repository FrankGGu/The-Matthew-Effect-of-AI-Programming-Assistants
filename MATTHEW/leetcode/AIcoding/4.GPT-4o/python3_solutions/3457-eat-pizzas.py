class Solution:
    def maxSizeSlices(self, slices: List[int], k: int) -> int:
        n = len(slices)
        dp = [[0] * (k + 1) for _ in range(n + 1)]

        for i in range(1, n + 1):
            for j in range(1, min(i, k) + 1):
                dp[i][j] = max(dp[i - 1][j], dp[i - 1][j - 1] + slices[i - 1])

        return dp[n][k]