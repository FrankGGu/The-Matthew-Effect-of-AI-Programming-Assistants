class Solution:
    def mirrorReflection(self, e: int, w: int) -> int:
        from math import gcd

        g = gcd(e, w)
        e //= g
        w //= g

        if e % 2 == 0:
            return 2
        elif w % 2 == 0:
            return 1
        else:
            return 0