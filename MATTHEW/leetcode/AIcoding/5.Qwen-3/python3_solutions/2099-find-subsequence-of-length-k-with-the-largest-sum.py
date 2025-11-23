from typing import List

class Solution:
    def maxSubsequence(self, nums: List[int], k: int) -> List[int]:
        indices = sorted(range(len(nums)), key=lambda i: -nums[i])
        selected = sorted(indices[:k])
        return [nums[i] for i in selected]