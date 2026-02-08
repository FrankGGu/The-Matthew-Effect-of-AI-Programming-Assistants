class Solution:
    def minimumOneBitOperations(self, n: int) -> int:
        res = 0
        while n > 0:
            res ^= n
            n >>= 1
        return res