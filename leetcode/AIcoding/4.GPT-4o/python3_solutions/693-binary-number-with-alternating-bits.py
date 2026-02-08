class Solution:
    def hasAlternatingBits(self, n: int) -> bool:
        last_bit = n & 1
        n >>= 1
        while n > 0:
            current_bit = n & 1
            if current_bit == last_bit:
                return False
            last_bit = current_bit
            n >>= 1
        return True