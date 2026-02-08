class Solution:
    def computeArea(self, ax1: int, ay1: int, ax2: int, ay2: int, bx1: int, by1: int, bx2: int, by2: int) -> int:
        area1 = (ax2 - ax1) * (ay2 - ay1)
        area2 = (bx2 - bx1) * (by2 - by1)

        overlap_x_start = max(ax1, bx1)
        overlap_y_start = max(ay1, by1)
        overlap_x_end = min(ax2, bx2)
        overlap_y_end = min(ay2, by2)

        overlap_width = max(0, overlap_x_end - overlap_x_start)
        overlap_height = max(0, overlap_y_end - overlap_y_start)

        overlap_area = overlap_width * overlap_height

        return area1 + area2 - overlap_area