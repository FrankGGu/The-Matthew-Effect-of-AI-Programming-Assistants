class Solution:
    def intersect(self, nums1: List[int], nums2: List[int]) -> List[int]:
        from collections import defaultdict

        freq = defaultdict(int)
        for num in nums1:
            freq[num] += 1

        result = []
        for num in nums2:
            if freq[num] > 0:
                result.append(num)
                freq[num] -= 1

        return result