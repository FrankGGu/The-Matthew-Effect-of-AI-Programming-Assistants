class Solution:
    def maxArea(self, width: int, height: int, points: List[List[int]]) -> int:
        points_set = set((x, y) for x, y in points)
        max_area = 0
        n = len(points)

        for i in range(n):
            x1, y1 = points[i]
            for j in range(i + 1, n):
                x2, y2 = points[j]
                if x1 != x2 and y1 != y2:
                    if (x1, y2) in points_set and (x2, y1) in points_set:
                        area = abs(x1 - x2) * abs(y1 - y2)
                        if area > max_area:
                            max_area = area

        return max_area