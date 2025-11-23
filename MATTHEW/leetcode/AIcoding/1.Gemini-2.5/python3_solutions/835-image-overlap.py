import collections

class Solution:
    def largestOverlap(self, img1: list[list[int]], img2: list[list[int]]) -> int:
        n = len(img1)

        ones_img1 = []
        ones_img2 = []

        for r in range(n):
            for c in range(n):
                if img1[r][c] == 1:
                    ones_img1.append((r, c))
                if img2[r][c] == 1:
                    ones_img2.append((r, c))

        shift_counts = collections.defaultdict(int)

        for r1, c1 in ones_img1:
            for r2, c2 in ones_img2:
                # If img2 is shifted such that the '1' at (r2, c2) aligns with the '1' at (r1, c1) in img1,
                # then the required translation vector (dr, dc) is (r1 - r2, c1 - c2).
                # This means img2 is effectively moved by (dr, dc) relative to img1.
                dr = r1 - r2
                dc = c1 - c2
                shift_counts[(dr, dc)] += 1

        max_overlap = 0
        if shift_counts:
            max_overlap = max(shift_counts.values())

        return max_overlap