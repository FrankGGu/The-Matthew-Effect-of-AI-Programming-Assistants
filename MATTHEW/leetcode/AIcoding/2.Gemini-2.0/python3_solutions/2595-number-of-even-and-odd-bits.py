class Solution:
    def evenOddBit(self, n: int) -> list[int]:
        even_count = 0
        odd_count = 0
        binary_str = bin(n)[2:]
        for i, bit in enumerate(reversed(binary_str)):
            if int(bit) == 1:
                if i % 2 == 0:
                    even_count += 1
                else:
                    odd_count += 1
        return [even_count, odd_count]