class Solution:
    def formSmallestNumber(self, nums1: list[int], nums2: list[int]) -> int:
        set1 = set(nums1)
        set2 = set(nums2)

        common_digits = set1.intersection(set2)

        if common_digits:
            return min(common_digits)
        else:
            min1 = min(nums1)
            min2 = min(nums2)
            return min(min1, min2) * 10 + max(min1, min2)