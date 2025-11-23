class Solution:
    def isRectangleCover(self, rectangles: List[List[int]]) -> bool:
        corner_count = defaultdict(int)
        total_area = 0

        for x1, y1, x2, y2 in rectangles:
            corner_count[(x1, y1)] += 1
            corner_count[(x1, y2)] += 1
            corner_count[(x2, y1)] += 1
            corner_count[(x2, y2)] += 1
            total_area += (x2 - x1) * (y2 - y1)

        if len(corner_count) != 4:
            return False

        corners = [(min(rectangles, key=lambda r: r[0])[0], min(rectangles, key=lambda r: r[1])[1]),
                    max(rectangles, key=lambda r: r[2])[0], max(rectangles, key=lambda r: r[3])[1])]

        if corner_count[corners[0]] != 1 or corner_count[corners[1]] != 1 or \
           corner_count[corners[2]] != 1 or corner_count[corners[3]] != 1:
            return False

        return total_area == (corners[2][0] - corners[0][0]) * (corners[2][1] - corners[0][1])