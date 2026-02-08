class Solution:
    def largestOverlap(self, img1: List[List[int]], img2: List[List[int]]) -> int:
        n = len(img1)
        ones1 = []
        ones2 = []
        for i in range(n):
            for j in range(n):
                if img1[i][j] == 1:
                    ones1.append((i, j))
                if img2[i][j] == 1:
                    ones2.append((i, j))

        count = {}
        for x1, y1 in ones1:
            for x2, y2 in ones2:
                dx = x1 - x2
                dy = y1 - y2
                if (dx, dy) in count:
                    count[(dx, dy)] += 1
                else:
                    count[(dx, dy)] = 1

        max_overlap = 0
        for val in count.values():
            max_overlap = max(max_overlap, val)

        return max_overlap