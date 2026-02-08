class Solution:
    def minFlips(self, a: int, b: int, c: int) -> int:
        flips = 0
        while a > 0 or b > 0 or c > 0:
            bit_a = a & 1
            bit_b = b & 1
            bit_c = c & 1

            if (bit_a | bit_b) != bit_c:
                if bit_c == 0:
                    # We want the result of OR to be 0, but it's 1.
                    # This means at least one of bit_a or bit_b is 1.
                    # To make the OR result 0, all 1s must be flipped to 0.
                    if bit_a == 1:
                        flips += 1
                    if bit_b == 1:
                        flips += 1
                else: # bit_c == 1
                    # We want the result of OR to be 1, but it's 0.
                    # This means both bit_a and bit_b are 0.
                    # To make the OR result 1, we need to flip one of them to 1.
                    # Only one flip is needed.
                    flips += 1

            a >>= 1
            b >>= 1
            c >>= 1

        return flips