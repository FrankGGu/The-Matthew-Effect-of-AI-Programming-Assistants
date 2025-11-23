class Solution:
    def isReachable(self, x: int, y: int, time: int) -> bool:
        if (x + y) > time or (time - (x + y)) % 2 != 0:
            return False
        return True