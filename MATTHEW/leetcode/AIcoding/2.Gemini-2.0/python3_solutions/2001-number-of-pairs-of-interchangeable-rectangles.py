from collections import defaultdict

class Solution:
    def interchangeableRectangles(self, rectangles: list[list[int]]) -> int:
        ratio_count = defaultdict(int)
        count = 0
        for width, height in rectangles:
            ratio = width / height
            count += ratio_count[ratio]
            ratio_count[ratio] += 1
        return count