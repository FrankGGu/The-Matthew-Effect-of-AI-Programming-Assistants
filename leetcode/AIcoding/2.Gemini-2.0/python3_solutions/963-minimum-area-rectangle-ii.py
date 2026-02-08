class Solution:
    def minAreaFreeRect(self, points: List[List[int]]) -> float:
        n = len(points)
        if n < 4:
            return 0.0

        point_set = set((x, y) for x, y in points)
        ans = float('inf')

        for i in range(n):
            for j in range(i + 1, n):
                p1 = points[i]
                p2 = points[j]
                len_sq = (p1[0] - p2[0]) ** 2 + (p1[1] - p2[1]) ** 2

                for k in range(j + 1, n):
                    p3 = points[k]
                    if (p1[0] - p2[0]) * (p1[0] - p3[0]) + (p1[1] - p2[1]) * (p1[1] - p3[1]) == 0:
                        p4_x = p2[0] + p3[0] - p1[0]
                        p4_y = p2[1] + p3[1] - p1[1]

                        if (p4_x, p4_y) in point_set:
                            area = ((p1[0] - p2[0]) ** 2 + (p1[1] - p2[1]) ** 2) ** 0.5 * ((p1[0] - p3[0]) ** 2 + (p1[1] - p3[1]) ** 2) ** 0.5
                            ans = min(ans, area)

        if ans == float('inf'):
            return 0.0
        else:
            return ans