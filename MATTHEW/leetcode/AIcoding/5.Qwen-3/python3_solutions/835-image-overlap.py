class Solution:
    def largestOverlap(self, img1, img2):
        n = len(img1)
        ones_img1 = [(i, j) for i in range(n) for j in range(n) if img1[i][j] == 1]
        ones_img2 = [(i, j) for i in range(n) for j in range(n) if img2[i][j] == 1]

        count = {}
        max_overlap = 0

        for x1, y1 in ones_img1:
            for x2, y2 in ones_img2:
                dx = x2 - x1
                dy = y2 - y1
                key = (dx, dy)
                count[key] = count.get(key, 0) + 1
                max_overlap = max(max_overlap, count[key])

        return max_overlap