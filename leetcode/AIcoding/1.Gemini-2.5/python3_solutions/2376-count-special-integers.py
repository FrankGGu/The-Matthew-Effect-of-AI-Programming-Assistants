class Solution:
    def countSpecialIntegers(self, n: int) -> int:
        s = str(n)
        L = len(s)
        ans = 0

        # Part 1: Count special integers with fewer digits than n
        # For k-digit numbers (1 <= k < L)
        for k in range(1, L):
            # The first digit can be chosen in 9 ways (1-9)
            # The remaining k-1 digits must be unique and chosen from the remaining 9 digits (0-9 excluding the first)
            # This is P(9, k-1)
            ans += 9 * self._permutations(9, k - 1)

        # Part 2: Count special integers with L digits, up to n
        # Iterate through digits of n from left to right
        used_digits_mask = 0  # Bitmask to keep track of used digits
        for i in range(L):
            digit_n = int(s[i])

            # Determine the starting digit for the current position 'i'
            # If it's the first digit (i=0), it cannot be 0.
            # Otherwise, it can be 0.
            start_digit = 1 if i == 0 else 0

            # Iterate through possible digits 'd' for the current position 'i'
            # 'd' must be less than digit_n (s[i]) to ensure the number is strictly less than n's prefix
            for d in range(start_digit, digit_n):
                # If digit 'd' has already been used in previous positions, skip it
                if (used_digits_mask >> d) & 1:
                    continue

                # If 'd' is not used, it's a valid choice for this position.
                # Calculate permutations for the remaining L - 1 - i positions.
                # Number of digits already used from previous positions: bin(used_digits_mask).count('1')
                # 'd' is also used for the current position.
                # So, total unique digits used for the current prefix: bin(used_digits_mask).count('1') + 1
                # Number of available digits for remaining positions: 10 - (bin(used_digits_mask).count('1') + 1)

                remaining_positions_count = L - 1 - i
                available_choices_count = 10 - bin(used_digits_mask).count('1') - 1
                ans += self._permutations(available_choices_count, remaining_positions_count)

            # After considering digits 'd < digit_n', now handle digit_n itself.
            # If digit_n has already been used in previous positions, then no numbers
            # with this prefix (s[0...i-1] + digit_n) can be special. Break the loop.
            if (used_digits_mask >> digit_n) & 1:
                break

            # Mark digit_n as used for the next iteration
            used_digits_mask |= (1 << digit_n)
        else:
            # If the loop completes without breaking, it means n itself is a special integer.
            # Add 1 for 'n' itself.
            ans += 1

        return ans

    # Helper function to calculate permutations P(n, k) = n! / (n-k)!
    def _permutations(self, n, k):
        if k < 0 or k > n:
            return 0
        res = 1
        for i in range(k):
            res *= (n - i)
        return res