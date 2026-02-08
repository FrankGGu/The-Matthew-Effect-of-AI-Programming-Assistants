class Solution:
    def isStrictlyPalindromic(self, n: int) -> bool:
        if n < 4:
            return False
        for base in range(2, n - 1 + 1):
            num = n
            digits = []
            while num > 0:
                digits.append(num % base)
                num //= base
            if digits != digits[::-1]:
                return False
        return True