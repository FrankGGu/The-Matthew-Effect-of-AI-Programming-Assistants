from collections import defaultdict

class Solution:
    def maxPoints(self, points: List[List[int]]) -> int:
        if len(points) <= 2:
            return len(points)

        max_points = 0

        for i in range(len(points)):
            x1, y1 = points[i]
            slope_counts = defaultdict(int)
            same_points = 1
            current_max = 0

            for j in range(i + 1, len(points)):
                x2, y2 = points[j]

                if x1 == x2 and y1 == y2:
                    same_points += 1
                else:
                    dx = x2 - x1
                    dy = y2 - y1
                    g = self.gcd(dx, dy)
                    slope = (dx // g, dy // g)
                    slope_counts[slope] += 1
                    current_max = max(current_max, slope_counts[slope])

            max_points = max(max_points, current_max + same_points)

        return max_points

    def gcd(self, a, b):
        while b:
            a, b = b, a % b
        return a