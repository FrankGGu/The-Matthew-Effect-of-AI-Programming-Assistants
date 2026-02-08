import random
import bisect

class Solution:

    def __init__(self, rects):
        self.rects = rects
        self.areas = []
        total_area = 0
        for x1, y1, x2, y2 in rects:
            area = (x2 - x1 + 1) * (y2 - y1 + 1)
            total_area += area
            self.areas.append(total_area)
        self.total_area = total_area

    def pick(self):
        rand_area = random.randint(1, self.total_area)
        rect_index = bisect.bisect_left(self.areas, rand_area)
        x1, y1, x2, y2 = self.rects[rect_index]
        width = x2 - x1 + 1
        height = y2 - y1 + 1
        x = x1 + random.randint(0, width - 1)
        y = y1 + random.randint(0, height - 1)
        return [x, y]