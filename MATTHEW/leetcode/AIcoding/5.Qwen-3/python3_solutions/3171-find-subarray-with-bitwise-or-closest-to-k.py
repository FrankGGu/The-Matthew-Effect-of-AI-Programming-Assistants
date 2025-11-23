from typing import List

class Solution:
    def closestToK(self, nums: List[int], k: int) -> int:
        min_diff = float('inf')
        result = float('inf')
        n = len(nums)
        for i in range(n):
            current_or = 0
            for j in range(i, n):
                current_or |= nums[j]
                diff = abs(current_or - k)
                if diff < min_diff:
                    min_diff = diff
                    result = current_or
                elif diff == min_diff and current_or < result:
                    result = current_or
        return result