import math

class Solution:
    def canMeasureWater(self, jug1_capacity: int, jug2_capacity: int, target_capacity: int) -> bool:
        if target_capacity == 0:
            return True
        if jug1_capacity + jug2_capacity < target_capacity:
            return False

        common_divisor = math.gcd(jug1_capacity, jug2_capacity)
        return target_capacity % common_divisor == 0