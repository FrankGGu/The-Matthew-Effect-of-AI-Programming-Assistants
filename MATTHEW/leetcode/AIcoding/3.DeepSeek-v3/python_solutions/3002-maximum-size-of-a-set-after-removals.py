class Solution:
    def maximumSetSize(self, nums1: List[int], nums2: List[int]) -> int:
        set1 = set(nums1)
        set2 = set(nums2)
        common = set1 & set2
        n = len(nums1)
        max_unique1 = min(len(set1) - len(common), n // 2)
        max_unique2 = min(len(set2) - len(common), n // 2)
        remaining = n - max_unique1 - max_unique2
        return min(max_unique1 + max_unique2 + min(len(common), remaining), n)