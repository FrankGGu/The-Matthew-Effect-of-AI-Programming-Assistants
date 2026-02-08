import random
import bisect

class Solution:

    def __init__(self, rects: List[List[int]]):
        self.rects = rects
        self.prefix = []
        total = 0
        for rect in rects:
            x1, y1, x2, y2 = rect
            area = (x2 - x1 + 1) * (y2 - y1 + 1)
            total += area
            self.prefix.append(total)

    def pick(self) -> List[int]:
        rand = random.randint(1, self.prefix[-1])
        idx = bisect.bisect_left(self.prefix, rand)
        x1, y1, x2, y2 = self.rects[idx]
        x = random.randint(x1, x2)
        y = random.randint(y1, y2)
        return [x, y]