class Solution:
    def minAreaRectangles(self, points: List[List[int]]) -> int:
        n = len(points)
        if n < 4:
            return 0

        point_set = set()
        for x, y in points:
            point_set.add((x, y))

        min_area = float('inf')

        for i in range(n):
            for j in range(i + 1, n):
                x1, y1 = points[i]
                x2, y2 = points[j]

                if x1 == x2 or y1 == y2:
                    continue

                if (x1, y2) in point_set and (x2, y1) in point_set:
                    area = abs(x1 - x2) * abs(y1 - y2)
                    min_area = min(min_area, area)

        return min_area if min_area != float('inf') else 0