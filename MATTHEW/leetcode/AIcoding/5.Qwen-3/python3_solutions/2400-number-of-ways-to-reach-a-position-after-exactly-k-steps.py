class Solution:
    def numberOfWays(self, startPos: int, endPos: int, k: int) -> int:
        MOD = 10**9 + 7
        from functools import lru_cache

        @lru_cache(None)
        def dp(pos, steps):
            if steps == 0:
                return 1 if pos == endPos else 0
            res = 0
            if pos > 0:
                res += dp(pos - 1, steps - 1)
            if pos < 10**5:
                res += dp(pos + 1, steps - 1)
            return res % MOD

        return dp(startPos, k)