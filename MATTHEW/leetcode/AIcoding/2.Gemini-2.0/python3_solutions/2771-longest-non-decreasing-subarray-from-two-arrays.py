class Solution:
    def maxNonDecreasingLength(self, nums1: List[int], nums2: List[int]) -> int:
        n = len(nums1)
        dp = [1] * n
        for i in range(1, n):
            if nums1[i] >= nums1[i - 1]:
                dp[i] = max(dp[i], dp[i - 1] + 1)
            if nums1[i] >= nums2[i - 1]:
                dp[i] = max(dp[i], dp[i - 1] + 1)
            if nums2[i] >= nums1[i - 1]:
                dp[i] = max(dp[i], dp[i - 1] + 1)
            if nums2[i] >= nums2[i - 1]:
                dp[i] = max(dp[i], dp[i - 1] + 1)

            temp = 1
            if nums1[i] >= nums1[i - 1]:
                temp = max(temp, dp[i - 1] + 1)
            else:
                temp = max(temp, 1)
            if nums1[i] >= nums2[i - 1]:
                temp = max(temp, dp[i - 1] + 1)
            else:
                temp = max(temp, 1)
            dp1 = temp

            temp = 1
            if nums2[i] >= nums1[i - 1]:
                temp = max(temp, dp[i - 1] + 1)
            else:
                temp = max(temp, 1)

            if nums2[i] >= nums2[i - 1]:
                temp = max(temp, dp[i - 1] + 1)
            else:
                temp = max(temp, 1)
            dp2 = temp

            temp = 1
            if nums1[i] >= nums1[i-1]:
                temp = max(temp, 1 + dp[i-1] if nums1[i] >= nums1[i-1] else 1)
            if nums1[i] >= nums2[i-1]:
                 temp = max(temp, 1 + dp[i-1] if nums1[i] >= nums2[i-1] else 1)
            dp[i] = temp

        result = 1
        for x in dp:
            result = max(result, x)
        return result