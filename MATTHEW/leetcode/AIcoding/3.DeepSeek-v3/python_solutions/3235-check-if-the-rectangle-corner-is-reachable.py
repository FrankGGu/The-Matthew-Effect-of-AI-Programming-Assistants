class Solution:
    def isReachable(self, targetX: int, targetY: int) -> bool:
        x, y = targetX, targetY
        while x % 2 == 0:
            x //= 2
        while y % 2 == 0:
            y //= 2
        return math.gcd(x, y) == 1