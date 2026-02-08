import math

class Solution:
    def largestPalindrome(self, n: int) -> int:
        # Special case for n=1 as per LeetCode problem example.
        # For n=1, the largest palindrome product is 9 (3 * 3).
        # The general algorithm constructing 2n-digit palindromes would not find 9.
        if n == 1:
            return 9

        # Calculate the upper and lower bounds for n-digit numbers.
        # For n=2, upper_bound = 99, lower_bound = 10.
        upper_bound = 10**n - 1
        lower_bound = 10**(n - 1)

        # Iterate through possible left halves of the palindrome, from largest to smallest.
        # A palindrome is constructed by taking an n-digit number 'i' and concatenating it
        # with its reverse (e.g., if i=123, palindrome is 123321).
        # The largest possible product of two n-digit numbers is (10^n - 1)^2.
        # The left half of such a palindrome would be approximately 10^n - 1.
        # The smallest possible product is (10^(n-1))^2.
        # The left half of such a palindrome would be approximately 10^(n-1).
        # So, 'i' (the left half) ranges from upper_bound down to lower_bound.
        for i in range(upper_bound, lower_bound - 1, -1):
            s_i = str(i)
            palindrome_str = s_i + s_i[::-1]
            p = int(palindrome_str)

            # Check if 'p' can be formed by the product of two n-digit numbers.
            # We need to find two factors, 'x' and 'y', such that:
            # lower_bound <= x <= upper_bound
            # lower_bound <= y <= upper_bound
            # p = x * y

            # Iterate 'x' (one factor) downwards from upper_bound.
            # The loop for 'x' should go down to `p // upper_bound`.
            # This is because if `x < p // upper_bound`, then `y = p / x` would be `> upper_bound`,
            # meaning 'y' would not be an n-digit number.
            # We also need to ensure `x` itself is an n-digit number, so `x >= lower_bound`.
            # Thus, the loop for 'x' runs from `upper_bound` down to `max(lower_bound, p // upper_bound)`.
            # The `p // upper_bound - 1` in range ensures the loop includes `p // upper_bound`.
            for x in range(upper_bound, p // upper_bound - 1, -1):
                # If x drops below lower_bound, it's no longer an n-digit number.
                # All subsequent x values will also be too small.
                if x < lower_bound:
                    break

                if p % x == 0:
                    y = p // x
                    # We already know `y <= upper_bound` from the range of `x` (specifically `x >= p // upper_bound`).
                    # We just need to check if `y` is also an n-digit number (i.e., `y >= lower_bound`).
                    if y >= lower_bound:
                        # Since we are iterating palindromes from largest to smallest,
                        # the first one we find that satisfies the conditions is the answer.
                        return p % 1337

        # This line should theoretically not be reached given the problem constraints
        # and the guarantee that a solution always exists.
        return -1