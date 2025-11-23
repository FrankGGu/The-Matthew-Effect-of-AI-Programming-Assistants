class Solution:
    def evenOddBit(self, n: int) -> List[int]:
        even = 0
        odd = 0
        for i in range(32):
            if (n >> i) & 1:
                if i % 2 == 0:
                    even += 1
                else:
                    odd += 1
        return [even, odd]