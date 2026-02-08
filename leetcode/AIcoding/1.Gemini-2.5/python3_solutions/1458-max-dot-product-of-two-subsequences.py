import math

class Solution:
    def maxDotProduct(self, nums1: list[int], nums2: list[int]) -> int:
        m, n = len(nums1), len(nums2)

        dp = [[-math.inf] * (n + 1) for _ in range(m + 1)]

        for i in range(1, m + 1):
            for j in range(1, n + 1):
                current_product = nums1[i-1] * nums2[j-1]

                # Option 1: Don't include nums1[i-1]
                # Option 2: Don't include nums2[j-1]
                # Option 3: Include both nums1[i-1] and nums2[j-1]
                #           This can either extend a previous subsequence (dp[i-1][j-1] + current_product)
                #           or start a new subsequence with just this pair (current_product itself).
                dp[i][j] = max(
                    dp[i-1][j], 
                    dp[i][j-1], 
                    current_product, 
                    dp[i-1][j-1] + current_product
                )

        return dp[m][n]