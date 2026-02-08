class Solution:
    def gcd(self, a, b):
        while b:
            a, b = b, a % b
        return a

    def isReachable(self, targetX: int, targetY: int) -> bool:
        return self.gcd(targetX, targetY) & (self.gcd(targetX, targetY) - 1) == 0