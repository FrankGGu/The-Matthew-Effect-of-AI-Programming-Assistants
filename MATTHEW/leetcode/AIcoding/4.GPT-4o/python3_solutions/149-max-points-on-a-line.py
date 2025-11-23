from collections import defaultdict
from math import gcd

class Solution:
    def maxPoints(self, points: List[List[int]]) -> int:
        def slope(p1, p2):
            dx = p2[0] - p1[0]
            dy = p2[1] - p1[1]
            if dx == 0:
                return (float('inf'), 0)
            g = gcd(dx, dy)
            return (dy // g, dx // g)

        if len(points) <= 2:
            return len(points)

        max_points = 1
        for i in range(len(points)):
            slopes = defaultdict(int)
            for j in range(len(points)):
                if i != j:
                    s = slope(points[i], points[j])
                    slopes[s] += 1
            max_points = max(max_points, max(slopes.values(), default=0) + 1)

        return max_points