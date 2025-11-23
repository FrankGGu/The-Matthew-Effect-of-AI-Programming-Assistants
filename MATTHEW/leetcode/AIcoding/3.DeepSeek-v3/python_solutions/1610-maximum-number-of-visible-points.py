import math

class Solution:
    def visiblePoints(self, points: List[List[int]], angle: int, location: List[int]) -> int:
        same = 0
        angles = []
        x, y = location

        for point in points:
            dx = point[0] - x
            dy = point[1] - y
            if dx == 0 and dy == 0:
                same += 1
                continue
            theta = math.atan2(dy, dx) * (180 / math.pi)
            angles.append(theta)

        angles.sort()
        angles = angles + [a + 360 for a in angles]
        max_count = 0
        left = 0
        n = len(angles)

        for right in range(n):
            while angles[right] - angles[left] > angle:
                left += 1
            max_count = max(max_count, right - left + 1)

        return max_count + same