class Solution:
    def canMeasureWater(self, x: int, y: int, z: int) -> bool:
        if z == 0:
            return True
        if x + y < z:
            return False
        from math import gcd
        return z % gcd(x, y) == 0