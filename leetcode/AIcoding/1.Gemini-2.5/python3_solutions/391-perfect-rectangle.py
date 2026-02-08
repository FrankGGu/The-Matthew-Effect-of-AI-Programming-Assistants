import math

class Solution:
    def isRectangleCover(self, rectangles: list[list[int]]) -> bool:
        if not rectangles:
            return False

        min_x = math.inf
        min_y = math.inf
        max_x = -math.inf
        max_y = -math.inf
        total_area = 0

        points = set()

        for rect in rectangles:
            x1, y1, x2, y2 = rect

            min_x = min(min_x, x1)
            min_y = min(min_y, y1)
            max_x = max(max_x, x2)
            max_y = max(max_y, y2)

            total_area += (x2 - x1) * (y2 - y1)

            # Add or remove corners from the set
            # If a point is added an even number of times, it will be removed
            # If a point is added an odd number of times, it will remain
            for p in [(x1, y1), (x1, y2), (x2, y1), (x2, y2)]:
                if p in points:
                    points.remove(p)
                else:
                    points.add(p)

        # Check 1: The set of points must contain exactly 4 points,
        # which are the corners of the bounding rectangle.
        if len(points) != 4 or \
           (min_x, min_y) not in points or \
           (min_x, max_y) not in points or \
           (max_x, min_y) not in points or \
           (max_x, max_y) not in points:
            return False

        # Check 2: The sum of individual areas must equal the area of the bounding rectangle.
        bounding_area = (max_x - min_x) * (max_y - min_y)
        if total_area != bounding_area:
            return False

        return True