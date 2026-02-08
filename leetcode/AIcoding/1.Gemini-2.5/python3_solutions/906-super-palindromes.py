class Solution:
    def superpalindromesInRange(self, L: str, R: str) -> int:
        L_int = int(L)
        R_int = int(R)
        count = 0

        def is_palindrome(n):
            s = str(n)
            return s == s[::-1]

        # Iterate through possible first halves of palindromes.
        # A super palindrome 'x' must satisfy x*x <= R_int.
        # Since R_int < 10^18, x < sqrt(10^18) = 10^9.
        # So 'x' can have at most 9 digits (e.g., 999,999,999).
        #
        # If 'x' is an odd-length palindrome (e.g., 121), it's formed by 's' + reverse(s[:-1]).
        # If x has 9 digits, then len(s) must be 5 (e.g., s="12345" -> x="123454321").
        # The largest such 's' is "99999".
        #
        # If 'x' is an even-length palindrome (e.g., 1221), it's formed by 's' + reverse(s).
        # If x has 8 digits, then len(s) must be 4 (e.g., s="1234" -> x="12344321").
        # The largest such 's' is "9999".
        #
        # Therefore, 'i' (the integer representation of 's') needs to go up to 99999.
        # We use range(1, 100000) to cover 'i' from 1 to 99999.

        for i in range(1, 100000): # i goes from 1 to 99999
            s = str(i)

            # Case 1: Palindromes with an odd number of digits (e.g., 121 from i=12)
            # Form x by concatenating s and the reverse of s excluding its last character.
            x_str_odd = s + s[:-1][::-1]
            x_odd = int(x_str_odd)

            sq_odd = x_odd * x_odd

            # Optimization: If sq_odd exceeds R_int, then all subsequent x_odd (and their squares)
            # will also exceed R_int because x_odd is strictly increasing with i.
            # Thus, we can break the loop early.
            if sq_odd > R_int:
                break 

            if sq_odd >= L_int: # No need to check sq_odd <= R_int again due to the break above
                if is_palindrome(sq_odd):
                    count += 1

            # Case 2: Palindromes with an even number of digits (e.g., 1221 from i=12)
            # Form x by concatenating s and its reverse.
            x_str_even = s + s[::-1]
            x_even = int(x_str_even)

            sq_even = x_even * x_even

            # We cannot break the loop here. Even if sq_even is too large for the current 'i',
            # x_odd for a subsequent 'i' might still be within the valid range.
            # The break condition for sq_odd handles the overall loop termination correctly.
            if sq_even >= L_int and sq_even <= R_int:
                if is_palindrome(sq_even):
                    count += 1

        return count