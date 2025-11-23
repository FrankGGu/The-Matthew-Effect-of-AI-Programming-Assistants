from typing import List

class Solution:
    def longestNiceSubarray(self, nums: List[int]) -> int:
        max_len = 0
        bit_mask = 0
        left = 0
        for right in range(len(nums)):
            while (bit_mask & nums[right]) != 0:
                bit_mask ^= nums[left]
                left += 1
            bit_mask |= nums[right]
            max_len = max(max_len, right - left + 1)
        return max_len