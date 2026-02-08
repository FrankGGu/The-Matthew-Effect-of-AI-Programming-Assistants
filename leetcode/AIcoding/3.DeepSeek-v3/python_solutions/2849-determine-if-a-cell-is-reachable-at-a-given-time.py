class Solution:
    def isReachableAtTime(self, sx: int, sy: int, fx: int, fy: int, t: int) -> bool:
        dx = abs(fx - sx)
        dy = abs(fy - sy)
        min_time = max(dx, dy)
        if dx == 0 and dy == 0:
            return t != 1
        return t >= min_time