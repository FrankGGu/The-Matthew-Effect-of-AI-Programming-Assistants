import collections

class Solution:
    def mergeArrays(self, nums1: list[list[int]], nums2: list[list[int]]) -> list[list[int]]:
        id_sums = collections.defaultdict(int)

        for id_val, val in nums1:
            id_sums[id_val] += val

        for id_val, val in nums2:
            id_sums[id_val] += val

        result = []
        for id_val in sorted(id_sums.keys()):
            result.append([id_val, id_sums[id_val]])

        return result