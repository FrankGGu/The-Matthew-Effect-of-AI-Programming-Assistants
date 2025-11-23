class Solution:
    def largestOverlap(self, img1: List[List[int]], img2: List[List[int]]) -> int:
        n = len(img1)
        ones1 = [(i, j) for i in range(n) for j in range(n) if img1[i][j] == 1]
        ones2 = [(i, j) for i in range(n) for j in range(n) if img2[i][j] == 1]

        from collections import defaultdict
        vector_counts = defaultdict(int)
        max_overlap = 0

        for (i1, j1) in ones1:
            for (i2, j2) in ones2:
                vector = (i2 - i1, j2 - j1)
                vector_counts[vector] += 1
                max_overlap = max(max_overlap, vector_counts[vector])

        return max_overlap