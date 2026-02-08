class Solution:
    def countGoodRectangles(self, rectangles: list[list[int]]) -> int:
        max_k = 0
        for l, w in rectangles:
            max_k = max(max_k, min(l, w))

        count = 0
        for l, w in rectangles:
            if min(l, w) == max_k:
                count += 1

        return count