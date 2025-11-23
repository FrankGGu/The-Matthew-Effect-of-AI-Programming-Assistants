class Solution:
    def maxArea(self, points: List[List[int]], x: int, y: int) -> int:
        points = sorted(points)
        x_points = sorted(p[0] for p in points)
        y_points = sorted(p[1] for p in points)

        max_area = 0

        for i in range(len(points)):
            for j in range(i + 1, len(points)):
                if points[i][0] < points[j][0] and points[i][1] < points[j][1]:
                    area = (points[j][0] - points[i][0]) * (points[j][1] - points[i][1])
                    if x > points[i][0] and x < points[j][0] and y > points[i][1] and y < points[j][1]:
                        max_area = max(max_area, area)

        return max_area