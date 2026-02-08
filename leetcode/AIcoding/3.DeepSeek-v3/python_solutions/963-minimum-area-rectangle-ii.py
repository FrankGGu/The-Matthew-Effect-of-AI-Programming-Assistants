import math

class Solution:
    def minAreaFreeRect(self, points: List[List[int]]) -> float:
        n = len(points)
        seen = set()
        for x, y in points:
            seen.add((x, y))

        min_area = float('inf')

        for i in range(n):
            x1, y1 = points[i]
            for j in range(n):
                if j == i:
                    continue
                x2, y2 = points[j]
                for k in range(n):
                    if k == i or k == j:
                        continue
                    x3, y3 = points[k]
                    # Check if (x3, y3) can be the opposite of (x1, y1) in the rectangle
                    # The vector (x2 - x1, y2 - y1) and (x3 - x1, y3 - y1) should be perpendicular
                    dx1 = x2 - x1
                    dy1 = y2 - y1
                    dx2 = x3 - x1
                    dy2 = y3 - y1
                    if dx1 * dx2 + dy1 * dy2 != 0:
                        continue
                    # Calculate the fourth point
                    x4 = x2 + x3 - x1
                    y4 = y2 + y3 - y1
                    if (x4, y4) in seen:
                        area = math.sqrt(dx1*dx1 + dy1*dy1) * math.sqrt(dx2*dx2 + dy2*dy2)
                        if area < min_area:
                            min_area = area

        return min_area if min_area != float('inf') else 0.0