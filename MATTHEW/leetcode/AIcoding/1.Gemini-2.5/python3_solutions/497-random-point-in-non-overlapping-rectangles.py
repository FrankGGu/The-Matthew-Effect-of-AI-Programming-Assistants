import random
import bisect

class Solution:

    def __init__(self, rects: list[list[int]]):
        self.rects = rects
        self.prefix_sums = []
        current_sum = 0
        for x1, y1, x2, y2 in rects:
            width = x2 - x1 + 1
            height = y2 - y1 + 1
            area = width * height
            current_sum += area
            self.prefix_sums.append(current_sum)
        self.total_area = current_sum

    def pick(self) -> list[int]:
        target = random.randrange(self.total_area)

        idx = bisect.bisect_right(self.prefix_sums, target)

        x1, y1, x2, y2 = self.rects[idx]

        rand_x = random.randint(x1, x2)
        rand_y = random.randint(y1, y2)

        return [rand_x, rand_y]