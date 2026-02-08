import math

class Solution:
    def maxDist(self, num: int, x: int, y: int) -> float:
        corners = [(0, 0), (0, 1), (1, 0), (1, 1)]
        max_distance = 0.0

        for (x1, y1) in corners:
            distance = math.sqrt((x - x1)**2 + (y - y1)**2)
            if distance > max_distance:
                max_distance = distance

        return max_distance