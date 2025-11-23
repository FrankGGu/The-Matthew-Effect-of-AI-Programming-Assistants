class Solution:
    def minOperations(self, nums1: List[int], nums2: List[int]) -> int:
        n = len(nums1)
        m = len(nums2)
        res = 0
        for i in range(n - 1):
            if nums1[i] > nums2[i]:
                nums1[i], nums2[i] = nums2[i], nums1[i]
                res += 1
        for i in range(m - 1):
            if nums1[i] > nums2[i]:
                nums1[i], nums2[i] = nums2[i], nums1[i]
                res += 1
        return res