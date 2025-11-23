class Solution:
    def evenOddBit(self, n: int) -> list[int]:
        even_freq = 0
        odd_freq = 0
        i = 0
        while n > 0:
            if n % 2 == 1:
                if i % 2 == 0:
                    even_freq += 1
                else:
                    odd_freq += 1
            n //= 2
            i += 1
        return [even_freq, odd_freq]