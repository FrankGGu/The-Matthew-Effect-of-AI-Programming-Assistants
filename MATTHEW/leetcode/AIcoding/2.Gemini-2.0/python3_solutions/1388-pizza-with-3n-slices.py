class Solution:
    def maxSizeSlices(self, slices: List[int]) -> int:
        n = len(slices)
        k = n // 3

        def solve(arr):
            m = len(arr)
            dp = [[0] * (k + 1) for _ in range(m + 1)]
            for i in range(1, m + 1):
                for j in range(1, k + 1):
                    dp[i][j] = max(dp[i - 1][j], (dp[i - 2][j - 1] if i >= 2 else 0) + arr[i - 1])
            return dp[m][k]

        return max(solve(slices[1:]), solve(slices[:-1]))