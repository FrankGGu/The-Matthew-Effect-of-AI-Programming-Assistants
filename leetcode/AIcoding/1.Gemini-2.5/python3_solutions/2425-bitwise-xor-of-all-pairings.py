class Solution:
    def xorAllNums(self, nums1: list[int], nums2: list[int]) -> int:
        n1 = len(nums1)
        n2 = len(nums2)

        xor1 = 0
        for num in nums1:
            xor1 ^= num

        xor2 = 0
        for num in nums2:
            xor2 ^= num

        result = 0

        if n2 % 2 != 0:
            result ^= xor1

        if n1 % 2 != 0:
            result ^= xor2

        return result