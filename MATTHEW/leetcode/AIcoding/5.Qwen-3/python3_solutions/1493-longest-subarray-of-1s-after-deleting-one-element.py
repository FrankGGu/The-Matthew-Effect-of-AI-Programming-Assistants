from typing import List

class Solution:
    def longestSubarray(self, nums: List[int]) -> int
        n = len(nums)
        left = 0
        max_len = 0
        count = 0
        for right in range(n):
            if nums[right] == 0:
                count += 1
            while count > 1:
                if nums[left] == 0:
                    count -= 1
                left += 1
            max_len = max(max_len, right - left)
        return max_len