class Solution:
    def sumIndicesWithKSetBits(self, nums: list[int], k: int) -> int:
        total_sum = 0
        for i in range(len(nums)):
            if bin(i).count('1') == k:
                total_sum += nums[i]
        return total_sum