class Solution:
    def maxPoints(self, points: List[List[int]]) -> int:
        if not points:
            return 0

        max_points = 0
        for i in range(len(points)):
            for j in range(i, len(points)):
                x_min = min(points[i][0], points[j][0])
                x_max = max(points[i][0], points[j][0])
                y_min = min(points[i][1], points[j][1])
                y_max = max(points[i][1], points[j][1])

                count = 0
                for x, y in points:
                    if x_min <= x <= x_max and y_min <= y <= y_max:
                        count += 1

                max_points = max(max_points, count)

        return max_points