import functools

class Solution:
    def countSteppingNumbers(self, low: str, high: str) -> int:

        def get_count(s_num_str):
            if s_num_str == "-1":
                return 0

            n = len(s_num_str)

            @functools.lru_cache(None)
            def dp(idx, prev_digit, is_tight, is_started):
                if idx == n:
                    # A number is valid if it has started (i.e., not all leading zeros).
                    # The number '0' itself is handled by adding 1 to the final result.
                    # So, if 'is_started' is False here, it means we formed "00", "000", etc., which are not distinct valid numbers.
                    return 1 if is_started else 0

                count = 0
                upper_bound = int(s_num_str[idx]) if is_tight else 9

                for digit in range(upper_bound + 1):
                    if is_started: # Number has started, apply stepping rule
                        if abs(digit - prev_digit) == 1:
                            count += dp(idx + 1, digit, is_tight and (digit == upper_bound), True)
                    else: # Still in leading zero state
                        if digit == 0:
                            # Still placing leading zeros, prev_digit remains 0 (dummy for this state)
                            count += dp(idx + 1, digit, is_tight and (digit == upper_bound), False)
                        else:
                            # Placed a non-zero digit, number starts
                            count += dp(idx + 1, digit, is_tight and (digit == upper_bound), True)
                return count

            # Initial call:
            # idx=0: starting from the first digit
            # prev_digit=0: dummy value as no non-zero digit has been placed yet
            # is_tight=True: initially restricted by the digits of s_num_str
            # is_started=False: no non-zero digit has been placed yet
            ans = dp(0, 0, True, False)

            # Add 1 for the number 0, which is a stepping number and not counted by the dp function
            # (since 'is_started' would be False when forming '0').
            return ans + 1

        count_high = get_count(high)

        # Calculate count for (low - 1)
        # Convert low to int, subtract 1, convert back to string.
        # Handle the case where low is "0", resulting in -1.
        low_minus_1_str = str(int(low) - 1)
        count_low_minus_1 = get_count(low_minus_1_str)

        return count_high - count_low_minus_1