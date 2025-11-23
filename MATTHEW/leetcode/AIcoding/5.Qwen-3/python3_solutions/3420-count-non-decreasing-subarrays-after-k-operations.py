from typing import List

class Solution:
    def countSubarrays(self, nums: List[int], k: int) -> int:
        n = len(nums)
        res = 0
        for i in range(n):
            j = i
            while j < n and (j == i or nums[j] >= nums[j - 1]):
                res += 1
                j += 1
        return res