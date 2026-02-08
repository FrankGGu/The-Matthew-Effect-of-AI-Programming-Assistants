from math import gcd
from functools import lru_cache

class Solution:
    def maxScore(self, nums: list[int]) -> int:
        n = len(nums)
        @lru_cache(None)
        def solve(mask, op):
            if mask == (1 << n) - 1:
                return 0

            max_score = 0
            for i in range(n):
                if (mask >> i) & 1 == 0:
                    for j in range(i + 1, n):
                        if (mask >> j) & 1 == 0:
                            new_mask = mask | (1 << i) | (1 << j)
                            max_score = max(max_score, op * gcd(nums[i], nums[j]) + solve(new_mask, op + 1))
            return max_score

        return solve(0, 1)