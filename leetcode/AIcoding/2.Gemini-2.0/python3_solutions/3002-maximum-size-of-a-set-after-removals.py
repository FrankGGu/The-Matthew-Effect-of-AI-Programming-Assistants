class Solution:
    def maximumSetSize(self, nums1: List[int], nums2: List[int]) -> int:
        n = len(nums1)
        s1 = set(nums1)
        s2 = set(nums2)

        common = s1.intersection(s2)

        s1_only = s1 - common
        s2_only = s2 - common

        len_s1_only = len(s1_only)
        len_s2_only = len(s2_only)
        len_common = len(common)

        remove1 = max(0, len_s1_only - n // 2)
        remove2 = max(0, len_s2_only - n // 2)

        len_s1_only = max(0, len_s1_only - remove1)
        len_s2_only = max(0, len_s2_only - remove2)

        len_common = min(len_common, n - len_s1_only - len_s2_only)

        return len_s1_only + len_s2_only + len_common