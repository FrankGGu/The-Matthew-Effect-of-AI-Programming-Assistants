import math

class Solution:
    def minAreaFreeRect(self, points: List[List[int]]) -> float:
        n = len(points)
        seen = {}
        min_area = float('inf')

        for i in range(n):
            x1, y1 = points[i]
            for j in range(i + 1, n):
                x2, y2 = points[j]
                dx = x2 - x1
                dy = y2 - y1
                length_sq = dx * dx + dy * dy
                center_x = (x1 + x2) / 2.0
                center_y = (y1 + y2) / 2.0
                key = (length_sq, center_x, center_y)
                if key in seen:
                    for (x3, y3) in seen[key]:
                        area = math.sqrt((x1 - x3)**2 + (y1 - y3)**2) * math.sqrt((x2 - x3)**2 + (y2 - y3)**2)
                        min_area = min(min_area, area)
                    seen[key].append((x1, y1))
                else:
                    seen[key] = [(x1, y1)]

        return min_area if min_area != float('inf') else 0.0