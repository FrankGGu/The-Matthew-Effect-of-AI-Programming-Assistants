class Solution:
    def maxSum(self, nums1: List[int], nums2: List[int]) -> int:
        MOD = 10**9 + 7
        i, j = 0, 0
        sum1, sum2 = 0, 0
        m, n = len(nums1), len(nums2)
        res = 0

        while i < m and j < n:
            if nums1[i] < nums2[j]:
                sum1 += nums1[i]
                i += 1
            elif nums1[i] > nums2[j]:
                sum2 += nums2[j]
                j += 1
            else:
                res += max(sum1, sum2) + nums1[i]
                sum1, sum2 = 0, 0
                i += 1
                j += 1

        while i < m:
            sum1 += nums1[i]
            i += 1

        while j < n:
            sum2 += nums2[j]
            j += 1

        res += max(sum1, sum2)

        return res % MOD