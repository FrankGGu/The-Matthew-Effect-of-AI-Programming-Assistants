class Solution:
    def isReachableAtTime(self, sx: int, sy: int, fx: int, fy: int, t: int) -> bool:
        dx = abs(sx - fx)
        dy = abs(sy - fy)

        if dx == 0 and dy == 0:
            return t != 1

        min_time = max(dx, dy)

        return t >= min_time