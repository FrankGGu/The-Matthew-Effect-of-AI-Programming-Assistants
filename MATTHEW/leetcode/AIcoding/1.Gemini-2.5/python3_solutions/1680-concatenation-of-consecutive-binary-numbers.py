class Solution:
    def concatenatedBinary(self, n: int) -> int:
        MOD = 10**9 + 7
        result = 0
        length = 0  # Stores the bit length of the current number 'i'
        for i in range(1, n + 1):
            # Check if 'i' is a power of 2. If it is, its bit length increases by 1 compared to 'i-1'.
            # This is equivalent to checking if i & (i - 1) == 0 for i > 0.
            # A more direct way to find bit length is i.bit_length().
            # However, we can optimize by only incrementing length when i becomes a new power of 2.
            # For example, 1 (len 1), 2 (len 2), 3 (len 2), 4 (len 3), 5 (len 3)
            # When i is a power of 2, like 1, 2, 4, 8, etc., its bit length is 1 + (bit length of i/2).
            # This condition checks if i is a power of 2: i & (i - 1) == 0.
            # For i=1, 1 & 0 == 0. length becomes 1.
            # For i=2, 2 & 1 == 0. length becomes 2.
            # For i=3, 3 & 2 != 0. length remains 2.
            # For i=4, 4 & 3 == 0. length becomes 3.
            if (i & (i - 1)) == 0:
                length += 1

            # Shift the current result by 'length' bits to the left to make space for the binary representation of 'i'.
            # Then, bitwise OR 'i' into the shifted result.
            # Take modulo MOD at each step to prevent overflow.
            result = ((result << length) | i) % MOD

        return result