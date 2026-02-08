class Solution:
    def mergeArrays(self, nums1: List[List[int]], nums2: List[List[int]]) -> List[List[int]]:
        merged = {}
        for id, val in nums1:
            merged[id] = merged.get(id, 0) + val
        for id, val in nums2:
            merged[id] = merged.get(id, 0) + val
        return sorted(merged.items())