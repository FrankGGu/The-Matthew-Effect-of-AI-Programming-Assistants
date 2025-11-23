class Solution:
    def evenOddBit(self, n: int) -> list[int]:
        even_bits = 0
        odd_bits = 0
        position = 0

        while n > 0:
            if (n & 1) == 1:
                if position % 2 == 0:
                    even_bits += 1
                else:
                    odd_bits += 1

            n >>= 1
            position += 1

        return [even_bits, odd_bits]