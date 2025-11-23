from typing import List

class Solution:
    def atMostN_givenDigitSet(self, digits: List[str], n: int) -> int:
        S = str(n)
        L = len(S)
        D = len(digits)

        ans = 0

        # Count numbers with fewer digits than N
        # For each length from 1 to L-1, there are D^length numbers
        for i in range(1, L):
            ans += D ** i

        # Count numbers with the same number of digits as N
        # Iterate through the digits of N from left to right
        for i in range(L):
            # Current digit of N
            n_digit = int(S[i])

            # Flag to check if n_digit itself is present in the allowed digits
            can_match_current_n_digit = False

            for d_str in digits:
                d_int = int(d_str)

                if d_int < n_digit:
                    # If we use a digit smaller than n_digit at this position,
                    # any combination of the D allowed digits can fill the remaining L - 1 - i positions.
                    ans += D ** (L - 1 - i)
                elif d_int == n_digit:
                    # If we use n_digit at this position, we mark that it's possible
                    # to match N further, and continue to the next position.
                    can_match_current_n_digit = True

            # If n_digit itself is not in the allowed digits,
            # we cannot form any more numbers that match N up to this point.
            # So, we break the loop as no numbers starting with the current prefix
            # (which includes n_digit) can be formed.
            if not can_match_current_n_digit:
                break

            # If we have successfully iterated through all digits of N (i.e., reached the last digit)
            # and the last digit of N was in the `digits` set, it means N itself is a valid number.
            if i == L - 1:
                ans += 1

        return ans