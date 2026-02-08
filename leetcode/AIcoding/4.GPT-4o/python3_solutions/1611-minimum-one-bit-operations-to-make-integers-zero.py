class Solution:
    def minimumOneBitOperations(self, n: int) -> int:
        if n == 0:
            return 0
        highest_power = 1
        while highest_power <= n:
            highest_power <<= 1
        return (highest_power - 1) - self.minimumOneBitOperations(n - (highest_power >> 1))