class Solution:
    def maxSum(self, nums1: List[int], nums2: List[int]) -> int:
        n1, n2 = len(nums1), len(nums2)
        i, j = 0, 0
        sum1, sum2 = 0, 0
        res = 0
        while i < n1 or j < n2:
            if i < n1 and (j == n2 or nums1[i] < nums2[j]):
                sum1 += nums1[i]
                i += 1
            elif j < n2 and (i == n1 or nums2[j] < nums1[i]):
                sum2 += nums2[j]
                j += 1
            else:
                res += max(sum1, sum2) + nums1[i]
                sum1, sum2 = 0, 0
                i += 1
                j += 1
        res += max(sum1, sum2)
        return res % (10**9 + 7)