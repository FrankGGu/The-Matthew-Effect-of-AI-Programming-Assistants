class Solution:
    def minNumber(self, nums1: list[int], nums2: list[int]) -> int:
        s1 = set(nums1)
        s2 = set(nums2)
        intersection = s1.intersection(s2)
        if intersection:
            return min(intersection)

        min1 = min(nums1)
        min2 = min(nums2)

        return min(min1 * 10 + min2, min2 * 10 + min1)