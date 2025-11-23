class Solution:
    def numberOfBeautifulIntegers(self, low: int, high: int, k: int) -> int:
        s_low = str(low)
        s_high = str(high)
        len_low = len(s_low)
        len_high = len(s_high)

        def f(s: str) -> int:
            n = len(s)
            memo = {}

            def dfs(pos, tight, leading_zero, cnt_even, cnt_odd, rem, is_num):
                if pos == n:
                    return 1 if (is_num and cnt_even == cnt_odd and rem == 0) else 0
                key = (pos, tight, leading_zero, cnt_even, cnt_odd, rem, is_num)
                if key in memo:
                    return memo[key]

                limit = int(s[pos]) if tight else 9
                res = 0

                for d in range(0, limit + 1):
                    new_tight = tight and (d == limit)
                    new_leading_zero = leading_zero and (d == 0)
                    new_is_num = is_num or (d != 0)

                    new_cnt_even = cnt_even
                    new_cnt_odd = cnt_odd
                    if new_is_num:
                        if d % 2 == 0:
                            new_cnt_even += 1
                        else:
                            new_cnt_odd += 1

                    new_rem = (rem * 10 + d) % k if new_is_num else 0

                    res += dfs(pos + 1, new_tight, new_leading_zero, new_cnt_even, new_cnt_odd, new_rem, new_is_num)

                memo[key] = res
                return res

            return dfs(0, True, True, 0, 0, 0, False)

        total = f(s_high) - f(str(low - 1)) if low > 1 else f(s_high)
        return total