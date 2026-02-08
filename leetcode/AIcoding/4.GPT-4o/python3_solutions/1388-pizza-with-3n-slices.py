class Solution:
    def maxSizeSlices(self, slices: List[int], n: int) -> int:
        k = len(slices) // 3
        dp = [[0] * (n + 1) for _ in range(k + 1)]

        for i in range(1, k + 1):
            for j in range(1, n + 1):
                for l in range(i * 2 - 1, min(len(slices), i * 2 + 1)):
                    dp[i][j] = max(dp[i][j], dp[i - 1][j - 1] + slices[l])

        return dp[k][n]