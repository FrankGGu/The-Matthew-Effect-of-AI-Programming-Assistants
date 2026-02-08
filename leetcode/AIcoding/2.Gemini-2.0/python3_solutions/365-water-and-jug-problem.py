class Solution:
    def canMeasureWater(self, jug1Capacity: int, jug2Capacity: int, targetCapacity: int) -> bool:
        if targetCapacity > jug1Capacity + jug2Capacity:
            return False
        if targetCapacity == 0:
            return True

        def gcd(a, b):
            while b:
                a, b = b, a % b
            return a

        g = gcd(jug1Capacity, jug2Capacity)
        return targetCapacity % g == 0