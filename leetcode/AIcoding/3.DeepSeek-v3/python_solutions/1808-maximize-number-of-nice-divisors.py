class Solution:
    def maxNiceDivisors(self, primeFactors: int) -> int:
        if primeFactors == 1:
            return 1
        mod = 10**9 + 7
        q, r = divmod(primeFactors, 3)
        if r == 0:
            return pow(3, q, mod)
        elif r == 1:
            return pow(3, q - 1, mod) * 4 % mod
        else:
            return pow(3, q, mod) * 2 % mod