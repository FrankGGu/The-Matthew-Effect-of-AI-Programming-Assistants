class Solution:
    def mirrorReflection(self, p: int, q: int) -> int:
        from math import gcd
        g = gcd(p, q)
        p //= g
        q //= g
        if p % 2 == 1 and q % 2 == 1:
            return 1
        elif p % 2 == 0 and q % 2 == 1:
            return 2
        else:
            return 0