class Solution:
    def concatenatedBinary(self, n: int) -> int:
        ans = 0
        MOD = 10**9 + 7
        for i in range(1, n + 1):
            # Calculate the number of bits required for the binary representation of i
            # For example, 1 needs 1 bit ("1"), 2 needs 2 bits ("10"), 3 needs 2 bits ("11")
            num_bits = i.bit_length()

            # Shift the current accumulated answer (ans) to the left by num_bits
            # This effectively makes space for the binary representation of i
            # Then, bitwise OR with i to append its binary representation
            # Finally, take modulo MOD to keep the number within limits
            ans = ((ans << num_bits) | i) % MOD

        return ans