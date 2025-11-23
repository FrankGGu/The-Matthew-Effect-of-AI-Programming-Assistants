import math

class Solution:
    def isReachable(self, tx: int, ty: int) -> bool:
        return math.gcd(tx, ty) == 1