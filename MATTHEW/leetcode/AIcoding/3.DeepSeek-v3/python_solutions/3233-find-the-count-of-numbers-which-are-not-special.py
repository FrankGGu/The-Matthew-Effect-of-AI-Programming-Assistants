class Solution:
    def countSpecialNumbers(self, n: int) -> int:
        s = str(n)
        length = len(s)

        from functools import lru_cache

        @lru_cache(maxsize=None)
        def dfs(pos, tight, mask, is_num):
            if pos == length:
                return 1 if is_num else 0
            limit = int(s[pos]) if tight else 9
            res = 0
            if not is_num:
                res += dfs(pos + 1, False, mask, False)
            for d in range(0 if is_num else 1, limit + 1):
                if not (mask & (1 << d)):
                    new_tight = tight and (d == limit)
                    new_mask = mask | (1 << d)
                    res += dfs(pos + 1, new_tight, new_mask, True)
            return res

        return n - dfs(0, True, 0, False)