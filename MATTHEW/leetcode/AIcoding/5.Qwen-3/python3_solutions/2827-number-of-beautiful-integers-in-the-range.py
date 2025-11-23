class Solution:
    def numberOfBeautifulIntegers(self, s: str, t: str) -> int:
        from functools import lru_cache

        def count(n: str) -> int:
            n = list(map(int, n))
            digits = len(n)
            @lru_cache(None)
            def dp(pos, tight, cnt, leading):
                if pos == digits:
                    return 1 if cnt == 0 and not leading else 0
                limit = n[pos] if tight else 9
                res = 0
                for d in range(0, limit + 1):
                    new_tight = tight and (d == limit)
                    new_leading = leading and (d == 0)
                    new_cnt = cnt
                    if not new_leading:
                        if d % 2 == 0:
                            new_cnt += 1
                        else:
                            new_cnt -= 1
                    res += dp(pos + 1, new_tight, new_cnt, new_leading)
                return res
            return dp(0, True, 0, True)

        def solve(s: str, t: str) -> int:
            return count(t) - count(s)

        return solve(s, t)