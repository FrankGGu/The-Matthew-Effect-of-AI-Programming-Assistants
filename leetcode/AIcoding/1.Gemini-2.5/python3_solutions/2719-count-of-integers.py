class Solution:
    def _count_less_than_or_equal(self, s: str, min_sum: int, max_sum: int) -> int:
        n = len(s)
        MOD = 10**9 + 7

        memo = {}

        def dp(index: int, current_sum: int, is_tight: bool, is_leading_zero: bool) -> int:
            if current_sum > max_sum:
                return 0

            if index == n:
                return 1 if min_sum <= current_sum <= max_sum else 0

            state = (index, current_sum, is_tight, is_leading_zero)
            if state in memo:
                return memo[state]

            ans = 0
            upper_bound = int(s[index]) if is_tight else 9

            for digit in range(upper_bound + 1):
                if is_leading_zero and digit == 0:
                    ans = (ans + dp(index + 1, 0, is_tight and (digit == upper_bound), True)) % MOD
                else:
                    ans = (ans + dp(index + 1, current_sum + digit, is_tight and (digit == upper_bound), False)) % MOD

            memo[state] = ans
            return ans

        return dp(0, 0, True, True)

    def count(self, num1: str, num2: str, min_sum: int, max_sum: int) -> int:
        count_up_to_num2 = self._count_less_than_or_equal(num2, min_sum, max_sum)

        num1_int = int(num1)
        num1_minus_1_str = str(num1_int - 1)

        count_up_to_num1_minus_1 = self._count_less_than_or_equal(num1_minus_1_str, min_sum, max_sum)

        MOD = 10**9 + 7
        ans = (count_up_to_num2 - count_up_to_num1_minus_1 + MOD) % MOD

        return ans