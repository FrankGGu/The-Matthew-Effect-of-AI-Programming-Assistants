import random

class Solution:

    def __init__(self, rects: List[List[int]]):
        self.rects = rects
        self.prefix_sums = []
        total_area = 0

        for x1, y1, x2, y2 in rects:
            area = (x2 - x1) * (y2 - y1)
            total_area += area
            self.prefix_sums.append(total_area)

    def pick(self) -> List[int]:
        target = random.randint(1, self.prefix_sums[-1])
        low, high = 0, len(self.prefix_sums) - 1

        while low < high:
            mid = (low + high) // 2
            if self.prefix_sums[mid] < target:
                low = mid + 1
            else:
                high = mid

        rect_index = low
        x1, y1, x2, y2 = self.rects[rect_index]
        area_before = self.prefix_sums[rect_index - 1] if rect_index > 0 else 0
        offset = target - area_before - 1

        width = x2 - x1
        height = y2 - y1

        return [x1 + offset % width, y1 + offset // width]