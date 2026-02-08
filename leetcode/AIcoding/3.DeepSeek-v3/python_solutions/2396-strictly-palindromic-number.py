class Solution:
    def isStrictlyPalindromic(self, n: int) -> bool:
        for b in range(2, n - 1):
            num = n
            digits = []
            while num > 0:
                digits.append(num % b)
                num = num // b
            if digits != digits[::-1]:
                return False
        return True