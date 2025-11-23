class Solution:
    def evenOddBit(self, n: int) -> List[int]:
        even_count = odd_count = 0
        for i in range(32):
            if (n >> i) & 1:
                if i % 2 == 0:
                    even_count += 1
                else:
                    odd_count += 1
        return [even_count, odd_count]