from typing import List

class Solution:
    def absoluteSum(self, nums: List[int]) -> int:
        n = len(nums)
        res = 0
        for i in range(n):
            res += nums[i] * i - nums[i] * (n - i - 1)
        return res