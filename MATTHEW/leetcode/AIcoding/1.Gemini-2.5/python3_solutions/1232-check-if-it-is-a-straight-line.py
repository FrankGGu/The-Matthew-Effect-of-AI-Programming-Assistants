from typing import List

class Solution:
    def checkStraightLine(self, coordinates: List[List[int]]) -> bool:
        n = len(coordinates)
        if n <= 2:
            return True

        x0, y0 = coordinates[0]
        x1, y1 = coordinates[1]

        dx_ref = x1 - x0
        dy_ref = y1 - y0

        for i in range(2, n):
            xi, yi = coordinates[i]
            if (yi - y0) * dx_ref != (xi - x0) * dy_ref:
                return False

        return True