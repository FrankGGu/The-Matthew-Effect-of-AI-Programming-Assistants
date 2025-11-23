from typing import List

class Solution:
    def maxNonDecreasingSubarray(self, nums1: List[int], nums2: List[int]) -> int:
        n = len(nums1)
        max_len = 1
        curr_len = 1

        for i in range(1, n):
            if nums1[i] >= nums1[i-1] and nums2[i] >= nums2[i-1]:
                curr_len += 1
            elif nums1[i] >= nums2[i-1]:
                curr_len = 2
            elif nums2[i] >= nums1[i-1]:
                curr_len = 2
            else:
                curr_len = 1

            max_len = max(max_len, curr_len)

        return max_len