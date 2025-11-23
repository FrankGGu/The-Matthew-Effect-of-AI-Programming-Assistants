class Solution:
    def minimizeXor(self, num1: int, num2: int) -> int:

        def countSetBits(n: int) -> int:
            count = 0
            while n > 0:
                n &= (n - 1)
                count += 1
            return count

        k = countSetBits(num2)

        x = 0

        # First pass: try to match num1's set bits from MSB to LSB
        # This minimizes XOR by making bits equal where possible.
        # Iterate from bit 30 down to 0, as numbers are up to 10^9 (2^29 is ~5*10^8, 2^30 is ~10^9).
        for i in range(30, -1, -1):
            if (num1 >> i) & 1:  # If the i-th bit of num1 is set
                if k > 0:
                    x |= (1 << i) # Set the i-th bit of x
                    k -= 1

        # Second pass: if k > 0, we still need to set k bits in x.
        # These remaining bits must be placed in positions where num1 has a 0
        # (because if num1 had a 1, we would have matched it in the first pass if k > 0).
        # To minimize the XOR sum, place these bits at the LSB positions where x is currently 0.
        if k > 0:
            for i in range(31): # Iterate from bit 0 up to 30
                if not ((x >> i) & 1): # If the i-th bit of x is NOT set
                    x |= (1 << i) # Set the i-th bit of x
                    k -= 1
                    if k == 0:
                        break

        return x