import math
from collections import deque

class Solution:
    def visiblePoints(self, points: List[List[int]], angle: int, location: List[int]) -> int:
        points = [[math.atan2(y - location[1], x - location[0]) for x, y in points]]
        points.sort()
        points += [p + 2 * math.pi for p in points]

        max_visible = 0
        left = 0
        for right in range(len(points)):
            while points[right] - points[left] > math.radians(angle):
                left += 1
            max_visible = max(max_visible, right - left + 1)

        return max_visible