class Solution:
    def sumIndicesWithKSetBits(self, nums: List[int], k: int) -> int:
        total_sum = 0
        for i, num in enumerate(nums):
            bits = bin(i)[2:].count('1')
            if bits == k:
                total_sum += num
        return total_sum