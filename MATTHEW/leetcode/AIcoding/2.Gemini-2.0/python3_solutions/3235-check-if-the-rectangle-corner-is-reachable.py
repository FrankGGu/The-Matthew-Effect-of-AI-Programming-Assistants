import math

class Solution:
    def isRectangleCover(self, sx: int, sy: int, ex: int, ey: int, tx: int, ty: int) -> bool:
        return math.gcd(ex - sx, ey - sy) == 1