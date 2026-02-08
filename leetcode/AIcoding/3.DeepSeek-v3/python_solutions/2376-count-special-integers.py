class Solution:
    def countSpecialNumbers(self, n: int) -> int:
        s = str(n)
        k = len(s)
        memo = {}

        def dp(pos, tight, mask, is_num):
            if pos == k:
                return 1 if is_num else 0
            key = (pos, tight, mask, is_num)
            if key in memo:
                return memo[key]
            limit = int(s[pos]) if tight else 9
            res = 0
            if not is_num:
                res = dp(pos + 1, False, mask, False)
            for d in range(0 if is_num else 1, limit + 1):
                if not (mask & (1 << d)):
                    new_tight = tight and (d == limit)
                    new_mask = mask | (1 << d)
                    res += dp(pos + 1, new_tight, new_mask, True)
            memo[key] = res
            return res

        return dp(0, True, 0, False)