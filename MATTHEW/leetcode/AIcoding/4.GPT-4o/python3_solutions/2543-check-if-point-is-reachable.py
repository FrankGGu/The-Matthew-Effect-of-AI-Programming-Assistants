class Solution:
    def isReachable(self, targetX: int, targetY: int) -> bool:
        while targetX > 0 and targetY > 0:
            if targetX > targetY:
                targetX %= targetY
            else:
                targetY %= targetX
        return targetX == 1 or targetY == 1 or (targetX == 0 and targetY == 0)