class Solution:
    def countGoodIntegers(self, num: str) -> int:
        MOD = 10**9 + 7
        n = len(num)

        memo = {}

        def dp(pos, tight, prev_digit, leading_zero):
            if pos == n:
                return 0 if leading_zero else 1

            key = (pos, tight, prev_digit, leading_zero)
            if key in memo:
                return memo[key]

            limit = int(num[pos]) if tight else 9
            total = 0

            for d in range(0, limit + 1):
                new_tight = tight and (d == limit)
                new_leading_zero = leading_zero and (d == 0)

                if new_leading_zero:
                    total += dp(pos + 1, new_tight, prev_digit, new_leading_zero)
                else:
                    if leading_zero:
                        total += dp(pos + 1, new_tight, d, False)
                    else:
                        if abs(d - prev_digit) != 1:
                            continue
                        total += dp(pos + 1, new_tight, d, False)
                total %= MOD

            memo[key] = total
            return total

        return dp(0, True, 0, True)