from collections import defaultdict

class Solution:
    def interchangeableRectangles(self, rectangles: List[List[int]]) -> int:
        ratio_count = defaultdict(int)
        res = 0

        for w, h in rectangles:
            ratio = w / h
            res += ratio_count[ratio]
            ratio_count[ratio] += 1

        return res