class Solution:
    def xorAllOneBits(self, nums1: List[int], nums2: List[int]) -> int:
        from collections import Counter
        count1 = Counter(nums1)
        count2 = Counter(nums2)
        result = 0
        for num in count1:
            if count1[num] % 2 == 1:
                for _ in range(len(nums2)):
                    result ^= num
        for num in count2:
            if count2[num] % 2 == 1:
                for _ in range(len(nums1)):
                    result ^= num
        return result