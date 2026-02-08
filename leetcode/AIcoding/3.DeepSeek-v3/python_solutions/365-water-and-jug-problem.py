class Solution:
    def canMeasureWater(self, jug1Capacity: int, jug2Capacity: int, targetCapacity: int) -> bool:
        if jug1Capacity + jug2Capacity < targetCapacity:
            return False
        if jug1Capacity == targetCapacity or jug2Capacity == targetCapacity or jug1Capacity + jug2Capacity == targetCapacity:
            return True
        return targetCapacity % self.gcd(jug1Capacity, jug2Capacity) == 0

    def gcd(self, a, b):
        while b != 0:
            a, b = b, a % b
        return a