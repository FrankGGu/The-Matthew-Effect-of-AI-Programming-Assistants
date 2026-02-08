import math

class Solution:
    def isReachable(self, targetX: int, targetY: int) -> bool:
        x, y = targetX, targetY
        g = math.gcd(x, y)
        while g % 2 == 0:
            g //= 2
        return g == 1