from typing import List

class Solution:
    def longestAlternatingSubarray(self, nums: List[int]) -> int:
        n = len(nums)
        if n == 0:
            return 0
        max_len = 1
        current_len = 1
        for i in range(1, n):
            if (nums[i] > nums[i-1] and nums[i-1] < nums[i-2]) or (nums[i] < nums[i-1] and nums[i-1] > nums[i-2]):
                current_len += 1
                max_len = max(max_len, current_len)
            else:
                current_len = 1
        return max_len