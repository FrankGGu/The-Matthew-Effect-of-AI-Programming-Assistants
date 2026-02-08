class Solution:
    def bitwiseComplement(self, n: int) -> int:
        if n == 0:
            return 1

        # Calculate the number of bits required to represent n
        num_bits = n.bit_length()

        # Create a mask with all 1s for the same number of bits
        # For example, if n is 5 (101), num_bits is 3.
        # (1 << 3) is 1000 (decimal 8)
        # (1 << 3) - 1 is 0111 (decimal 7)
        mask = (1 << num_bits) - 1

        # The complement is obtained by XORing n with the mask
        # 101 (n) XOR 111 (mask) = 010 (complement)
        return n ^ mask