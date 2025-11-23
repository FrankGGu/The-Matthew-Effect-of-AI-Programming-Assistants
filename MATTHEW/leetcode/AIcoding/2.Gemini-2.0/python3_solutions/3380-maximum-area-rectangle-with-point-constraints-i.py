class Solution:
    def solve(self, points: list[list[int]]) -> int:
        if not points:
            return 0

        points.sort()
        n = len(points)
        max_area = 0

        for i in range(n):
            for j in range(i + 1, n):
                x1, y1 = points[i]
                x2, y2 = points[j]

                if x1 == x2 or y1 == y2:
                    continue

                if x2 < x1 or y2 < y1:
                    continue

                if [x1, y2] in points and [x2, y1] in points:
                    area = (x2 - x1) * (y2 - y1)
                    max_area = max(max_area, area)

        return max_area