class Solution:
    def minRectanglesToCoverPoints(self, points: list[int], w: int) -> int:
        points.sort()

        rectangles = 0
        i = 0
        n = len(points)

        while i < n:
            rectangles += 1
            current_rect_end = points[i] + w

            while i < n and points[i] <= current_rect_end:
                i += 1

        return rectangles