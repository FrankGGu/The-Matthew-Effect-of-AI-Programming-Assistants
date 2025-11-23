from typing import List

class Solution:
    def minSubsequence(self, nums: List[int]) -> List[int]:
        nums.sort(reverse=True)
        res = []
        total = sum(nums)
        current = 0
        for num in nums:
            res.append(num)
            current += num
            if current > total - current:
                break
        return res