class Solution:
    def maxDistance(self, nums1: List[int], nums2: List[int]) -> int:
        max_dist = 0
        j = len(nums2) - 1
        for i in range(len(nums1)):
            while j >= 0 and nums1[i] > nums2[j]:
                j -= 1
            if j >= i:
                max_dist = max(max_dist, j - i)
        return max_dist