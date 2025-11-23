class Solution:
    def count(self, num1: str, num2: str, min_sum: int, max_sum: int) -> int:
        MOD = 10**9 + 7

        def calculate(s: str) -> int:
            n = len(s)
            memo = {}

            def dp(pos: int, tight: bool, sum_digits: int) -> int:
                if pos == n:
                    return 1 if min_sum <= sum_digits <= max_sum else 0
                key = (pos, tight, sum_digits)
                if key in memo:
                    return memo[key]

                limit = int(s[pos]) if tight else 9
                total = 0

                for d in range(0, limit + 1):
                    new_tight = tight and (d == limit)
                    new_sum = sum_digits + d
                    if new_sum > max_sum:
                        continue
                    total += dp(pos + 1, new_tight, new_sum)
                    total %= MOD

                memo[key] = total
                return total

            return dp(0, True, 0)

        def is_valid(num: str) -> bool:
            digit_sum = sum(int(c) for c in num)
            return min_sum <= digit_sum <= max_sum

        total = (calculate(num2) - calculate(num1) + is_valid(num1)) % MOD
        return total