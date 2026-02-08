class Solution:
    def findValidSplit(self, nums: List[int]) -> bool:
        from math import gcd
        from functools import lru_cache

        @lru_cache(None)
        def can_split(index):
            if index == len(nums):
                return True
            g = 0
            for i in range(index, len(nums)):
                g = gcd(g, nums[i])
                if g == 1 and can_split(i + 1):
                    return True
            return False

        return can_split(0)