class Solution:
    def maxDotProduct(self, nums1: List[int], nums2: List[int]) -> int:
        n, m = len(nums1), len(nums2)
        dp = [[float('-inf')] * (m + 1) for _ in range(n + 1)]

        for i in range(n + 1):
            for j in range(m + 1):
                if i == 0 or j == 0:
                    dp[i][j] = float('-inf')
                else:
                    dp[i][j] = max(dp[i-1][j-1] + nums1[i-1] * nums2[j-1], dp[i-1][j], dp[i][j-1], nums1[i-1] * nums2[j-1])

        return dp[n][m]