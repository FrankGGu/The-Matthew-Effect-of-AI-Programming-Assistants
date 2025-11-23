class Solution:
    def isRectangleCover(self, rectangles: List[List[int]]) -> bool:
        area = 0
        corners = set()
        a, b, c, d = float('inf'), float('inf'), -float('inf'), -float('inf')

        for x1, y1, x2, y2 in rectangles:
            a = min(a, x1)
            b = min(b, y1)
            c = max(c, x2)
            d = max(d, y2)
            area += (x2 - x1) * (y2 - y1)

            for corner in [(x1, y1), (x1, y2), (x2, y1), (x2, y2)]:
                if corner in corners:
                    corners.remove(corner)
                else:
                    corners.add(corner)

        if len(corners) != 4:
            return False

        if (a, b) not in corners or (a, d) not in corners or (c, b) not in corners or (c, d) not in corners:
            return False

        return area == (c - a) * (d - b)