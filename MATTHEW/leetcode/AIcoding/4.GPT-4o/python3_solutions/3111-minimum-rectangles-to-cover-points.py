class Solution:
    def minRectangles(self, points: List[List[int]]) -> int:
        from collections import defaultdict

        if not points:
            return 0

        points_set = set(map(tuple, points))
        rectangles = 0

        for x1, y1 in points:
            for x2, y2 in points:
                if x1 < x2 and y1 < y2 and (x1, y2) in points_set and (x2, y1) in points_set:
                    rectangles += 1

        return rectangles