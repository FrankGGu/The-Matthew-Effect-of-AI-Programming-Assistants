class Solution:
    def houseOfCards(self, m: int) -> int:
        from functools import lru_cache

        @lru_cache(None)
        def dp(n, k):
            if n < 0:
                return 0
            if k == 1:
                return 1
            res = 0
            for i in range(1, n + 1):
                res += dp(n - i, k - 1)
            return res

        total = 0
        for k in range(1, m + 1):
            total += dp(m, k)
        return total