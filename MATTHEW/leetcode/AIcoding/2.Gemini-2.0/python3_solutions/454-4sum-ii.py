from collections import defaultdict

class Solution:
    def fourSumCount(self, nums1: List[int], nums2: List[int], nums3: List[int], nums4: List[int]) -> int:
        count = 0
        sum_map = defaultdict(int)
        for a in nums1:
            for b in nums2:
                sum_map[a + b] += 1
        for c in nums3:
            for d in nums4:
                count += sum_map[-(c + d)]
        return count