class Solution:
    def minAreaFreeRect(self, points: List[List[int]]) -> float:
        from collections import defaultdict
        from itertools import combinations

        point_set = set(map(tuple, points))
        points = [tuple(p) for p in points]
        diag_map = defaultdict(list)

        for (x1, y1), (x2, y2) in combinations(points, 2):
            if (x1, y1) != (x2, y2):
                diag = ((x1 + x2) / 2, (y1 + y2) / 2)
                angle = (x2 - x1, y2 - y1)
                diag_map[diag].append(angle)

        min_area = float('inf')

        for diag, angles in diag_map.items():
            if len(angles) < 2:
                continue
            for (dx1, dy1), (dx2, dy2) in combinations(angles, 2):
                if dx1 * dy2 == dx2 * dy1:
                    continue
                area = abs(dx1 * dy2 - dx2 * dy1) / 2
                min_area = min(min_area, area)

        return min_area if min_area < float('inf') else 0.0