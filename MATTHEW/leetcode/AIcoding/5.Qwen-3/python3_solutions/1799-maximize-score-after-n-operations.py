from typing import List
from math import gcd
from functools import lru_cache

class Solution:
    def maxScore(self, nums: List[int]) -> int:
        n = len(nums)

        @lru_cache(None)
        def dfs(mask):
            if mask == (1 << n) - 1:
                return 0
            res = 0
            for i in range(n):
                if not (mask & (1 << i)):
                    for j in range(i + 1, n):
                        if not (mask & (1 << j)):
                            new_mask = mask | (1 << i) | (1 << j)
                            score = gcd(nums[i], nums[j]) + dfs(new_mask)
                            res = max(res, score)
            return res

        return dfs(0)