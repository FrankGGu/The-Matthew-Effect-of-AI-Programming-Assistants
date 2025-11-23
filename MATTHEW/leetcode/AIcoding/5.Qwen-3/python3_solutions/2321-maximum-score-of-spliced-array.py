from typing import List

class Solution:
    def maximumsSplicedSum(self, nums1: List[int], nums2: List[int]) -> int:
        def maxSubarraySum(arr):
            max_ending_here = max_so_far = arr[0]
            for x in arr[1:]:
                max_ending_here = max(x, max_ending_here + x)
                max_so_far = max(max_so_far, max_ending_here)
            return max_so_far

        def computeDifference(arr1, arr2):
            return [a - b for a, b in zip(arr1, arr2)]

        diff1 = computeDifference(nums1, nums2)
        diff2 = computeDifference(nums2, nums1)

        maxDiff1 = maxSubarraySum(diff1)
        maxDiff2 = maxSubarraySum(diff2)

        sum1 = sum(nums1)
        sum2 = sum(nums2)

        return max(sum1 + maxDiff1, sum2 + maxDiff2)