class Solution:
    def countRightTriangles(self, points: List[List[int]]) -> int:
        point_set = set(map(tuple, points))
        count = 0

        for i in range(len(points)):
            for j in range(i + 1, len(points)):
                x1, y1 = points[i]
                x2, y2 = points[j]
                if (x1, y2) in point_set:
                    count += 1
                if (x2, y1) in point_set:
                    count += 1

        return count