class Solution:
    def computeArea(self, A: int, B: int, C: int, D: int, E: int, F: int, G: int, H: int) -> int:
        area1 = (C - A) * (D - B)
        area2 = (G - E) * (H - F)

        overlap_width = max(0, min(C, G) - max(A, E))
        overlap_height = max(0, min(D, H) - max(B, F))
        overlap_area = overlap_width * overlap_height

        return area1 + area2 - overlap_area