from typing import List

class Solution:
    def findKDistantIndices(self, nums: List[int], k: int) -> List[int]:
        result = []
        n = len(nums)
        for i in range(n):
            for j in range(n):
                if abs(i - j) <= k:
                    result.append(j)
        return result