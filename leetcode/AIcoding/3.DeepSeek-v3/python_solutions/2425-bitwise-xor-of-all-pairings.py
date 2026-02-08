class Solution:
    def xorAllNums(self, nums1: List[int], nums2: List[int]) -> int:
        m, n = len(nums1), len(nums2)
        res = 0
        if n % 2 == 1:
            for num in nums1:
                res ^= num
        if m % 2 == 1:
            for num in nums2:
                res ^= num
        return res