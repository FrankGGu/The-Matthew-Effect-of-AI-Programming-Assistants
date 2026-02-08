from collections import defaultdict

class Solution:
    def countAlmostEqualPairs(self, nums1: list[int], nums2: list[int]) -> int:
        n = len(nums1)

        counts = defaultdict(int)
        for k in range(n):
            counts[(nums1[k], nums2[k])] += 1

        total_pairs = 0
        for i in range(n):
            target_key = (nums2[i], nums1[i])
            total_pairs += counts[target_key]

        return total_pairs