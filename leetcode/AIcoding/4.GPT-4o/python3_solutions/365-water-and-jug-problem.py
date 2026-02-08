class Solution:
    def canMeasureWater(self, jug1: int, jug2: int, target: int) -> bool:
        if target > jug1 + jug2:
            return False
        if target == 0 or target == jug1 or target == jug2 or target == jug1 + jug2:
            return True

        def gcd(a, b):
            while b:
                a, b = b, a % b
            return a

        return target % gcd(jug1, jug2) == 0