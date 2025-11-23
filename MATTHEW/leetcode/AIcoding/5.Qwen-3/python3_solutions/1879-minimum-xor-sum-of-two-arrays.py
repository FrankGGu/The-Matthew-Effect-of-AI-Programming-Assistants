class Solution:
    def minimumXORSum(self, nums1: List[int], nums2: List[int]) -> int:
        from functools import lru_cache
        import math

        @lru_cache(None)
        def dp(mask, i):
            if i == len(nums1):
                return 0
            res = math.inf
            for j in range(len(nums2)):
                if not (mask & (1 << j)):
                    res = min(res, (nums1[i] ^ nums2[j]) + dp(mask | (1 << j), i + 1))
            return res

        return dp(0, 0)