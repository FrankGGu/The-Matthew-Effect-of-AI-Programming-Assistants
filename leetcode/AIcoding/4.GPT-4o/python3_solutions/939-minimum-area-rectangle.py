class Solution:
    def minAreaRect(self, points: List[List[int]]) -> int:
        point_set = set(map(tuple, points))
        min_area = float('inf')
        found = False

        for i in range(len(points)):
            for j in range(i + 1, len(points)):
                if points[i][0] != points[j][0] and points[i][1] != points[j][1]:
                    if (points[i][0], points[j][1]) in point_set and (points[j][0], points[i][1]) in point_set:
                        area = abs(points[i][0] - points[j][0]) * abs(points[i][1] - points[j][1])
                        min_area = min(min_area, area)
                        found = True

        return min_area if found else 0