class Solution:
    def separateSquares(self, points: List[List[int]]) -> int:
        def in_circle(p, center, radius):
            return (p[0] - center[0]) ** 2 + (p[1] - center[1]) ** 2 <= radius ** 2

        def count_in_circle(points, center, radius):
            count = 0
            for p in points:
                if in_circle(p, center, radius):
                    count += 1
            return count

        n = len(points)
        max_points = 0
        for i in range(n):
            for j in range(i + 1, n):
                mid_x = (points[i][0] + points[j][0]) / 2
                mid_y = (points[i][1] + points[j][1]) / 2
                radius = ((points[i][0] - points[j][0]) ** 2 + (points[i][1] - points[j][1]) ** 2) ** 0.5 / 2
                max_points = max(max_points, count_in_circle(points, (mid_x), radius))
                for k in range(n):
                    if k != i and k != j:
                        center_x = (points[i][0] + points[j][0] + points[k][0]) / 3
                        center_y = (points[i][1] + points[j][1] + points[k][1]) / 3
                        dist_i = ((points[i][0] - center_x) ** 2 + (points[i][1] - center_y) ** 2) ** 0.5
                        dist_j = ((points[j][0] - center_x) ** 2 + (points[j][1] - center_y) ** 2) ** 0.5
                        dist_k = ((points[k][0] - center_x) ** 2 + (points[k][1] - center_y) ** 2) ** 0.5
                        radius = max(dist_i, dist_j, dist_k)
                        max_points = max(max_points, count_in_circle(points, center_x, radius))

        return max_points