class Solution:
    def minTimeToVisitAllPoints(self, points: List[List[int]]) -> int:
        time = 0
        for i in range(len(points) - 1):
            x1, y1 = points[i]
            x2, y2 = points[i + 1]
            dx = abs(x2 - x1)
            dy = abs(y2 - y1)
            time += max(dx, dy)
        return time