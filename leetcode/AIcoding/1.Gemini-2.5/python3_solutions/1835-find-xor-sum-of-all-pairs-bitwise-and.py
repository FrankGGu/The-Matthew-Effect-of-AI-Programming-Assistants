class Solution:
    def xorSum(self, nums1: list[int], nums2: list[int]) -> int:
        xor_sum_nums1 = 0
        for num in nums1:
            xor_sum_nums1 ^= num

        xor_sum_nums2 = 0
        for num in nums2:
            xor_sum_nums2 ^= num

        return xor_sum_nums1 & xor_sum_nums2