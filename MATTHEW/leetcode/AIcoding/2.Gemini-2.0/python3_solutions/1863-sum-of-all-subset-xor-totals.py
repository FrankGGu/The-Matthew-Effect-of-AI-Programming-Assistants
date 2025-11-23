class Solution:
    def subsetXORSum(self, nums: List[int]) -> int:
        n = len(nums)
        total_xor_sum = 0
        for i in range(1 << n):
            subset_xor_sum = 0
            for j in range(n):
                if (i >> j) & 1:
                    subset_xor_sum ^= nums[j]
            total_xor_sum += subset_xor_sum
        return total_xor_sum