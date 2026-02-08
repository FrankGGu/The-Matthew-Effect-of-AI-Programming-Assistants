import math

class Solution:
    def numPoints(self, points: List[List[int]], r: int) -> int:
        def get_center(p1, p2, r):
            x1, y1 = p1
            x2, y2 = p2
            dx, dy = x2 - x1, y2 - y1
            q = math.sqrt(dx**2 + dy**2)
            if q > 2 * r:
                return None
            x3, y3 = (x1 + x2) / 2, (y1 + y2) / 2
            d = math.sqrt(r**2 - (q/2)**2)
            center1 = (x3 - d * dy / q, y3 + d * dx / q)
            center2 = (x3 + d * dy / q, y3 - d * dx / q)
            return [center1, center2]

        max_points = 1
        n = len(points)
        for i in range(n):
            for j in range(i + 1, n):
                centers = get_center(points[i], points[j], r)
                if not centers:
                    continue
                for center in centers:
                    cnt = 0
                    cx, cy = center
                    for point in points:
                        px, py = point
                        if (px - cx)**2 + (py - cy)**2 <= r**2 + 1e-6:
                            cnt += 1
                    if cnt > max_points:
                        max_points = cnt
        return max_points