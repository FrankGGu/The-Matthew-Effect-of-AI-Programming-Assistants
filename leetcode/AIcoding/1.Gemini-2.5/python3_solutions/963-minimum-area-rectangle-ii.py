import math

class Solution:
    def minAreaRect(self, points: list[list[int]]) -> float:
        n = len(points)
        if n < 4:
            return 0.0

        points_set = set(tuple(p) for p in points)
        min_area = float('inf')

        for i in range(n):
            p1 = points[i]
            for j in range(n):
                if i == j:
                    continue
                p2 = points[j]

                v1x = p2[0] - p1[0]
                v1y = p2[1] - p1[1]

                len_sq_1 = v1x * v1x + v1y * v1y
                if len_sq_1 == 0:
                    continue

                for k in range(n):
                    if k == i or k == j:
                        continue
                    p3 = points[k]

                    v2x = p3[0] - p2[0]
                    v2y = p3[1] - p2[1]

                    len_sq_2 = v2x * v2x + v2y * v2y
                    if len_sq_2 == 0:
                        continue

                    dot_product = v1x * v2x + v1y * v2y

                    if dot_product == 0:
                        p4x = p1[0] + v2x
                        p4y = p1[1] + v2y
                        p4 = (p4x, p4y)

                        if p4 in points_set:
                            area = math.sqrt(len_sq_1) * math.sqrt(len_sq_2)
                            min_area = min(min_area, area)

        if min_area == float('inf'):
            return 0.0
        else:
            return min_area