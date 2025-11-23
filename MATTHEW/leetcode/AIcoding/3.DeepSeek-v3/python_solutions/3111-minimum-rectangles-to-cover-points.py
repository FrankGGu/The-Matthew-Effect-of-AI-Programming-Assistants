class Solution:
    def minRectanglesToCoverPoints(self, points: List[List[int]], w: int) -> int:
        if not points:
            return 0
        points.sort()
        res = 1
        start = points[0][0]
        for x, y in points:
            if x - start > w:
                res += 1
                start = x
        return res