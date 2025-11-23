from collections import defaultdict

class Solution:
    def numberOfBoomerangs(self, points):
        count = 0
        for x1, y1 in points:
            distance_count = defaultdict(int)
            for x2, y2 in points:
                dx, dy = x1 - x2, y1 - y2
                distance_count[dx * dx + dy * dy] += 1
            for k in distance_count:
                count += distance_count[k] * (distance_count[k] - 1)
        return count