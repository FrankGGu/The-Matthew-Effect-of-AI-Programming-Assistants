class Solution:
    def modExp(self, a: int, b: int, m: int) -> int:
        return pow(a, b, m)

    def doubleModularExponentiation(self, a: int, b: int, m: int, c: int, d: int, n: int) -> int:
        first = self.modExp(a, b, m)
        second = self.modExp(c, d, n)
        return (first + second) % (m + n)