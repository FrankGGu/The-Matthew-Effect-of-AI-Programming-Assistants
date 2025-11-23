class Solution:
    def mergeArrays(self, nums1: List[List[int]], nums2: List[List[int]]) -> List[List[int]]:
        from collections import defaultdict

        merged = defaultdict(int)
        for id, val in nums1:
            merged[id] += val
        for id, val in nums2:
            merged[id] += val
        return sorted(merged.items())