class Solution:
    def makeTheIntegerZero(self, num1: int, num2: int) -> int:
        if num2 >= 0 and num1 < num2:
            return -1

        for k in range(1, 61):
            x = num1 - k * num2
            if x >= k and bin(x).count('1') <= k and x.bit_count() == bin(x).count('1'):
                return k
        return -1