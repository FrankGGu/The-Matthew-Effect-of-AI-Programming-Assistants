import math

class Solution:
    def superpalindromes(self, L: int, R: int) -> int:
        def is_palindrome(x):
            s = str(x)
            return s == s[::-1]

        res = 0
        for i in range(1, 100000):
            s = str(i)
            p = int(s + s[-2::-1])
            if p < L or p > R:
                continue
            if is_palindrome(p):
                res += 1
        for i in range(1, 100000):
            s = str(i)
            p = int(s + s[-1::-1])
            if p < L or p > R:
                continue
            if is_palindrome(p):
                res += 1
        return res