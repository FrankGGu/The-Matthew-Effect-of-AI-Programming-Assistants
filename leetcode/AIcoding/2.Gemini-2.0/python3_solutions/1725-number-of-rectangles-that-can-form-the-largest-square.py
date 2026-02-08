class Solution:
    def countGoodRectangles(self, rectangles: List[List[int]]) -> int:
        max_len = 0
        count = 0
        for rect in rectangles:
            side = min(rect[0], rect[1])
            if side > max_len:
                max_len = side
                count = 1
            elif side == max_len:
                count += 1
        return count