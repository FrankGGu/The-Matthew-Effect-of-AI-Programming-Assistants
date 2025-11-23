class Solution:
    def numberOfBeautifulIntegers(self, s: str) -> int:
        from functools import lru_cache

        @lru_cache(None)
        def dp(pos, tight, cnt0, cnt1, leading_zero):
            if pos == len(s):
                return 0 if leading_zero else (1 if cnt0 == cnt1 else 0)
            limit = int(s[pos]) if tight else 9
            res = 0
            for d in range(0, limit + 1):
                new_tight = tight and (d == limit)
                new_leading_zero = leading_zero and (d == 0)
                new_cnt0 = cnt0
                new_cnt1 = cnt1
                if not new_leading_zero:
                    if d % 2 == 0:
                        new_cnt0 += 1
                    else:
                        new_cnt1 += 1
                res += dp(pos + 1, new_tight, new_cnt0, new_cnt1, new_leading_zero)
            return res

        return dp(0, True, 0, 0, True)