import functools

class Solution:
    def countBeautifulNumbers(self, n: int) -> int:
        s = str(n)
        length = len(s)

        # The maximum sum of digits for any number x <= 10^9 is 81 (for 999,999,999).
        # For 1,000,000,000, the sum of digits is 1.
        # Thus, the maximum possible sum of digits for any x in the range [1, n] is 81.
        MAX_SUM_DIGITS = 81 

        total_beautiful_numbers = 0

        # Iterate over all possible target sums of digits.
        # A positive integer must have a sum of digits of at least 1.
        for target_sum in range(1, MAX_SUM_DIGITS + 1):
            # Use functools.lru_cache for memoization. The cache needs to be cleared
            # for each new target_sum, as the 'current_remainder' and 'current_sum_digits_so_far'
            # are relative to the current target_sum, but target_sum itself is not part of the state.
            # State: (index, current_remainder, current_sum_digits_so_far, is_less, is_started)
            # index: current digit position being considered (from 0 to length-1)
            # current_remainder: the number formed so far modulo target_sum
            # current_sum_digits_so_far: the sum of digits placed so far
            # is_less: boolean, true if the number formed so far is strictly less than the prefix of 'n'
            # is_started: boolean, true if we have placed at least one non-zero digit (to handle leading zeros)
            @functools.lru_cache(None)
            def dp(index: int, current_remainder: int, current_sum_digits_so_far: int, is_less: bool, is_started: bool) -> int:
                if index == length:
                    # Base case: if we have processed all digit positions.
                    # A number is beautiful if its sum of digits equals target_sum
                    # AND the number itself is divisible by target_sum (i.e., current_remainder is 0)
                    # AND it must be a positive integer (is_started must be True to exclude leading-zero-only numbers).
                    return 1 if is_started and current_sum_digits_so_far == target_sum and current_remainder == 0 else 0

                res = 0
                # Determine the upper bound for the current digit.
                # If 'is_less' is true, we can place any digit from 0 to 9.
                # Otherwise, we are constrained by the digit in 's[index]'.
                upper_bound = int(s[index]) if not is_less else 9

                for digit in range(upper_bound + 1):
                    if not is_started and digit == 0:
                        # Handling leading zeros:
                        # If we haven't started placing non-zero digits and the current digit is 0,
                        # it's still a leading zero. We do not update the sum of digits or the remainder.
                        # The 'is_less' flag is updated based on whether the current digit is less than upper_bound.
                        res += dp(index + 1, 0, 0, is_less or (digit < upper_bound), False)
                    else:
                        # If we have started placing non-zero digits (is_started is True)
                        # or the current digit is non-zero (meaning we are starting the number now):
                        # Update the remainder and sum of digits.
                        new_remainder = (current_remainder * 10 + digit) % target_sum
                        new_sum_digits = current_sum_digits_so_far + digit

                        # Optimization: if the sum of digits already exceeds the target_sum,
                        # this path cannot lead to a valid number for the current target_sum.
                        if new_sum_digits <= target_sum:
                            res += dp(index + 1, new_remainder, new_sum_digits, is_less or (digit < upper_bound), True)

                return res

            total_beautiful_numbers += dp(0, 0, 0, False, False)
            # Clear the cache for the next iteration of target_sum, as the memoized results are specific to the current target_sum.
            dp.cache_clear() 

        return total_beautiful_numbers