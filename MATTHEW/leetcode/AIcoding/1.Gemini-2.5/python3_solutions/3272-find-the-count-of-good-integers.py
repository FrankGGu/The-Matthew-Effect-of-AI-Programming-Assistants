class Solution:
    def findTheCountOfGoodIntegers(self, low: int, high: int, k: int) -> int:

        memo = {}

        def count_good_integers_up_to(N_str: str, K: int) -> int:
            nonlocal memo
            memo = {}

            def dp(idx: int, current_sum_mod_k: int, is_less: bool, is_started: bool) -> int:
                if idx == len(N_str):
                    return 1 if current_sum_mod_k == 0 else 0

                key = (idx, current_sum_mod_k, is_less, is_started)
                if key in memo:
                    return memo[key]

                res = 0
                upper_bound = int(N_str[idx]) if not is_less else 9

                for digit in range(upper_bound + 1):
                    if not is_started and digit == 0:
                        res += dp(idx + 1, 0, is_less or (digit < upper_bound), False)
                    else:
                        new_sum_mod_k = (current_sum_mod_k + digit) % K
                        res += dp(idx + 1, new_sum_mod_k, is_less or (digit < upper_bound), True)

                memo[key] = res
                return res

            return dp(0, 0, False, False)

        count_high = count_good_integers_up_to(str(high), k)
        count_low_minus_1 = count_good_integers_up_to(str(low - 1), k)

        return count_high - count_low_minus_1