class Solution:
    def minFlips(self, s: str) -> int:
        n = len(s)

        # A single character string is always alternating with 0 flips.
        # Problem constraints state 1 <= s.length, so n will be at least 1.
        if n == 1:
            return 0

        # Create an extended string by concatenating s with itself.
        # This allows us to simulate cyclic shifts using a sliding window.
        s_extended = s + s

        # Initialize flip counts for two alternating patterns for the current window:
        # flips1_cur: for target pattern "01010..."
        # flips2_cur: for target pattern "10101..."
        flips1_cur = 0
        flips2_cur = 0

        # Calculate initial flips for the first window s_extended[0:n]
        for j in range(n):
            # Determine the expected character for each pattern at relative index j
            expected_char1 = '0' if j % 2 == 0 else '1' # Target 1: '0' at even, '1' at odd
            expected_char2 = '1' if j % 2 == 0 else '0' # Target 2: '1' at even, '0' at odd

            # Compare with the actual character and increment flip counts if they don't match
            if s_extended[j] != expected_char1:
                flips1_cur += 1
            if s_extended[j] != expected_char2:
                flips2_cur += 1

        # Initialize the minimum flips found so far
        min_flips = min(flips1_cur, flips2_cur)

        # Slide the window across s_extended
        # The loop runs n-1 times, considering n total windows (including the initial one)
        for i in range(1, n):
            # Character leaving the window (s_extended[i-1])
            # Its relative index in the previous window was 0.
            char_out = s_extended[i-1]

            # Decrement flip counts if the leaving character contributed to a flip
            if char_out != '0': # '0' is expected at relative index 0 for pattern 1
                flips1_cur -= 1
            if char_out != '1': # '1' is expected at relative index 0 for pattern 2
                flips2_cur -= 1

            # Character entering the window (s_extended[i+n-1])
            # Its relative index in the current window is n-1.
            char_in = s_extended[i+n-1]

            # Determine the expected characters for pattern 1 and 2 at relative index n-1
            expected_char1_in = '0' if (n-1) % 2 == 0 else '1'
            expected_char2_in = '1' if (n-1) % 2 == 0 else '0'

            # Increment flip counts if the entering character contributes to a flip
            if char_in != expected_char1_in:
                flips1_cur += 1
            if char_in != expected_char2_in:
                flips2_cur += 1

            # When the window slides, all relative indices j become j-1.
            # This effectively flips the parity of all indices (even becomes odd, odd becomes even).
            # Consequently, the "0101..." pattern effectively becomes "1010..." for the new window,
            # and the "1010..." pattern effectively becomes "0101...".
            # We swap the flip counts to reflect this change in effective patterns.
            flips1_cur, flips2_cur = flips2_cur, flips1_cur

            # Update the minimum flips found
            min_flips = min(min_flips, flips1_cur, flips2_cur)

        return min_flips