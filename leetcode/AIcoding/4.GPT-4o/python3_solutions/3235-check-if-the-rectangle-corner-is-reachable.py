class Solution:
    def isReachable(self, x: int, y: int) -> bool:
        while x > 0 and y > 0:
            if x > y:
                x %= y
            else:
                y %= x
        return (x == 1 and y >= 0) or (y == 1 and x >= 0)