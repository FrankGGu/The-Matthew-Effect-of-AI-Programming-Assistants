class Solution:
    def minRectanglesToCoverPoints(self, points: List[List[int]], w: int) -> int:
        points.sort()
        res = 0
        i = 0
        while i < len(points):
            res += 1
            x = points[i][0]
            while i < len(points) and points[i][0] - x <= w:
                i += 1
        return res