import math

class Solution:
    def maxVisiblePoints(self, points: list[list[int]], angle: int, location: list[int]) -> int:
        angles = []
        same = 0
        for x, y in points:
            dx = x - location[0]
            dy = y - location[1]
            if dx == 0 and dy == 0:
                same += 1
            else:
                ang = math.atan2(dy, dx) * 180 / math.pi
                angles.append(ang)
        angles.sort()
        n = len(angles)
        angles += [a + 360 for a in angles]
        max_points = 0
        left = 0
        for right in range(len(angles)):
            while angles[right] - angles[left] > angle:
                left += 1
            max_points = max(max_points, right - left + 1)
        return max_points + same