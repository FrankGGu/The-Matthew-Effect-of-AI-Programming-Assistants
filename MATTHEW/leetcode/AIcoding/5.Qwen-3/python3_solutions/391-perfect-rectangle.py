class Solution:
    def isRectangleCover(self, rectangles: List[List[int]]) -> bool:
        from collections import defaultdict

        def getArea(rect):
            return (rect[2] - rect[0]) * (rect[3] - rect[1])

        total_area = 0
        corners = defaultdict(int)
        min_x, min_y, max_x, max_y = float('inf'), float('inf'), -float('inf'), -float('inf')

        for x1, y1, x2, y2 in rectangles:
            total_area += getArea([x1, y1, x2, y2])
            min_x = min(min_x, x1)
            min_y = min(min_y, y1)
            max_x = max(max_x, x2)
            max_y = max(max_y, y2)

            for point in [(x1, y1), (x1, y2), (x2, y1), (x2, y2)]:
                corners[point] += 1

        expected_area = (max_x - min_x) * (max_y - min_y)
        if total_area != expected_area:
            return False

        for point, count in corners.items():
            if count % 2 == 1:
                if (point[0] == min_x or point[0] == max_x) and (point[1] == min_y or point[1] == max_y):
                    continue
                else:
                    return False

        return True