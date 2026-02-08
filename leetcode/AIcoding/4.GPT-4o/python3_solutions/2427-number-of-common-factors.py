class Solution:
    def commonFactors(self, a: int, b: int) -> int:
        def gcd(x, y):
            while y:
                x, y = y, x % y
            return x

        count = 0
        g = gcd(a, b)
        for i in range(1, g + 1):
            if g % i == 0:
                count += 1

        return count