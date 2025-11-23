class Solution:
    def minimumLines(self, points: List[List[int]]) -> int:
        if len(points) <= 1:
            return 0

        points.sort()

        lines = 1

        def slope(p1, p2):
            if p2[0] - p1[0] == 0:
                return float('inf')
            return (p2[1] - p1[1]) / (p2[0] - p1[0])

        prev_slope = slope(points[0], points[1])

        for i in range(2, len(points)):
            curr_slope = slope(points[i-1], points[i])
            if curr_slope != prev_slope:
                lines += 1
                prev_slope = curr_slope

        return lines