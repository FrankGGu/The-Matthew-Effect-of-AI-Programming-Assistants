class Solution:
    def countAlmostEqualPairs(self, nums1: List[int], nums2: List[int]) -> int:
        from collections import Counter

        count1 = Counter(nums1)
        count2 = Counter(nums2)

        result = 0

        for num in count1:
            for diff in [-1, 0, 1]:
                if num + diff in count2:
                    result += count1[num] * count2[num + diff]

        return result