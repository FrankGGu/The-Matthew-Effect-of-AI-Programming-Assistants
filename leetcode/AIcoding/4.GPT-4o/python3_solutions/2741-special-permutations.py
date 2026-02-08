class Solution:
    def specialPerm(self, nums: List[int]) -> int:
        from math import gcd
        from functools import lru_cache

        n = len(nums)
        mod = 10**9 + 7

        @lru_cache(None)
        def dfs(mask, last):
            if mask == (1 << n) - 1:
                return 1

            count = 0
            for i in range(n):
                if mask & (1 << i) == 0 and (last == -1 or gcd(last, nums[i]) > 1):
                    count += dfs(mask | (1 << i), nums[i])
                    count %= mod
            return count

        result = 0
        for i in range(n):
            result += dfs(1 << i, nums[i])
            result %= mod

        return result