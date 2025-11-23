from typing import List

class Solution:
    def intersection(self, nums: List[List[int]]) -> List[int]:
        if not nums:
            return []

        result = set(nums[0])
        for i in range(1, len(nums)):
            result = result.intersection(set(nums[i]))

        return sorted(list(result))