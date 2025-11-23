class Solution:
    def commonFactors(self, a: int, b: int) -> int:
        def gcd(x, y):
            while y:
                x, y = y, x % y
            return x

        g = gcd(a, b)
        count = 0
        for i in range(1, int(g**0.5) + 1):
            if g % i == 0:
                if i * i == g:
                    count += 1
                else:
                    count += 2
        return count