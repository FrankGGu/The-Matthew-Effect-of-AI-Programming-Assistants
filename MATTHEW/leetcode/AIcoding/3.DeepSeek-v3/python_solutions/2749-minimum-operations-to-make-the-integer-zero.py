class Solution:
    def makeIntegerZero(self, num1: int, num2: int) -> int:
        for k in range(0, 60):
            target = num1 - k * num2
            if target < 0:
                continue
            bits = bin(target).count('1')
            if bits <= k and target >= k:
                return k
        return -1