class Solution:
    def findMinArrowShots(self, points: list[list[int]]) -> int:
        if not points:
            return 0

        points.sort(key=lambda x: x[1])

        arrows = 1
        last_arrow_pos = points[0][1]

        for i in range(1, len(points)):
            current_balloon_start = points[i][0]
            current_balloon_end = points[i][1]

            if current_balloon_start > last_arrow_pos:
                arrows += 1
                last_arrow_pos = current_balloon_end

        return arrows