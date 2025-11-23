class Solution:
    def minimumOneBitOperations(self, n: int) -> int:
        if n == 0:
            return 0
        return (1 << n.bit_length()) - 1 - self.minimumOneBitOperations(n ^ (1 << (n.bit_length() - 1)))