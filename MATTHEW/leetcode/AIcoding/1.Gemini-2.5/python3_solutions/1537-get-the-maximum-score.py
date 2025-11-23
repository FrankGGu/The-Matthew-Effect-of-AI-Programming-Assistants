class Solution:
    def maxSum(self, nums1: list[int], nums2: list[int]) -> int:
        MOD = 10**9 + 7

        i, j = 0, 0
        n, m = len(nums1), len(nums2)

        sum1 = 0
        sum2 = 0

        while i < n and j < m:
            if nums1[i] < nums2[j]:
                sum1 += nums1[i]
                i += 1
            elif nums2[j] < nums1[i]:
                sum2 += nums2[j]
                j += 1
            else:  # nums1[i] == nums2[j]
                current_val = nums1[i]
                sum1 = sum2 = max(sum1, sum2) + current_val
                i += 1
                j += 1

        while i < n:
            sum1 += nums1[i]
            i += 1

        while j < m:
            sum2 += nums2[j]
            j += 1

        return max(sum1, sum2) % MOD