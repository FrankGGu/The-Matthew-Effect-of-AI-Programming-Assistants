class Solution:
    def subsetXORSum(self, nums: List[int]) -> int:
        total = 0
        n = len(nums)
        for i in range(2**n):
            subset_xor = 0
            for j in range(n):
                if i & (1 << j):
                    subset_xor ^= nums[j]
            total += subset_xor
        return total