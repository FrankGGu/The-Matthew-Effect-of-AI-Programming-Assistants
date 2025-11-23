import functools

class Solution:
    def numberOfBeautifulIntegers(self, low: int, high: int, k: int) -> int:

        def count_beautiful_up_to(num_str: str) -> int:
            s = num_str
            n = len(s)

            # Max length of number string is 10 for high <= 10^9.
            # The 'even_diff' (even_count - odd_count) can range from -n to n.
            # To use it as a cache key, we offset it by n_max_offset to make it non-negative.
            # For n=10, even_diff ranges from -10 to 10. Offset by 10, it becomes 0 to 20.
            n_max_offset = 10 

            @functools.lru_cache(None)
            def dp(idx: int, tight: bool, is_leading_zero: bool, even_diff_offset: int, rem: int) -> int:
                """
                idx: Current digit position we are considering (from left, 0 to n-1).
                tight: True if we are restricted by the digits of 's' at current and subsequent positions.
                       False if we can place any digit from 0-9.
                is_leading_zero: True if we are currently placing leading zeros.
                                 Leading zeros do not contribute to even/odd counts or remainder.
                even_diff_offset: (even_count - odd_count) + n_max_offset.
                                  Used to track the balance of even and odd digits.
                rem: Current remainder of the number formed so far when divided by k.
                """
                if idx == n:
                    # Base case: We have formed a complete number.
                    # A number is beautiful if:
                    # 1. It's not just a sequence of leading zeros (i.e., a non-empty number was formed).
                    # 2. Number of even digits equals number of odd digits (even_diff == 0).
                    # 3. The number is divisible by k (rem == 0).
                    return 1 if not is_leading_zero and (even_diff_offset - n_max_offset) == 0 and rem == 0 else 0

                ans = 0
                # Determine the upper bound for the current digit.
                # If 'tight' is True, the digit cannot exceed s[idx]. Otherwise, it can be up to 9.
                upper_bound = int(s[idx]) if tight else 9

                for digit in range(upper_bound + 1):
                    if is_leading_zero and digit == 0:
                        # If we are still placing leading zeros, and the current digit is 0,
                        # it doesn't contribute to even/odd count or remainder.
                        # even_diff_offset remains n_max_offset (meaning even_diff = 0).
                        # rem remains 0.
                        ans += dp(idx + 1, tight and (digit == upper_bound), True, n_max_offset, 0)
                    else:
                        # This is a significant digit (either the first non-zero digit, or subsequent digits).
                        # Update even_diff, remainder, and set is_leading_zero to False.
                        current_even_diff = even_diff_offset - n_max_offset
                        new_even_diff = current_even_diff + (1 if digit % 2 == 0 else -1)
                        new_even_diff_offset = new_even_diff + n_max_offset
                        new_rem = (rem * 10 + digit) % k
                        ans += dp(idx + 1, tight and (digit == upper_bound), False, new_even_diff_offset, new_rem)

                return ans

            # Initial call to DP function:
            # idx=0 (start from the first digit)
            # tight=True (initially restricted by the input number string 's')
            # is_leading_zero=True (initially we are looking for the first non-zero digit)
            # even_diff_offset=n_max_offset (initial even_diff is 0, offset by n_max_offset)
            # rem=0 (initial remainder is 0)
            result = dp(0, True, True, n_max_offset, 0)
            dp.cache_clear() # Clear cache for subsequent calls to count_beautiful_up_to
            return result

        # The problem asks for the number of beautiful integers in the range [low, high].
        # This can be calculated as count_beautiful_up_to(high) - count_beautiful_up_to(low - 1).
        return count_beautiful_up_to(str(high)) - count_beautiful_up_to(str(low - 1))