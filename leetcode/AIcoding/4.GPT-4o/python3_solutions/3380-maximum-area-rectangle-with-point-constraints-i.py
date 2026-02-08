class Solution:
    def maxRectangle(self, points: List[List[int]]) -> int:
        points_set = set(map(tuple, points))
        max_area = 0

        for i in range(len(points)):
            for j in range(i + 1, len(points)):
                if points[i][0] != points[j][0] and points[i][1] != points[j][1]:
                    if (points[i][0], points[j][1]) in points_set and (points[j][0], points[i][1]) in points_set:
                        area = abs(points[i][0] - points[j][0]) * abs(points[i][1] - points[j][1])
                        max_area = max(max_area, area)

        return max_area