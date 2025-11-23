class Solution:
    def mirrorReflection(self, n: int) -> int:
        from math import gcd

        def lcm(a, b):
            return a * b // gcd(a, b)

        k = lcm(n, n)
        m = k // n
        if m % 2 == 0:
            return 1
        else:
            return 0