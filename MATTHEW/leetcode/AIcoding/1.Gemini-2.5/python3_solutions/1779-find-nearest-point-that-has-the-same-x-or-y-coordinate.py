import math

class Solution:
    def nearestValidPoint(self, x: int, y: int, points: list[list[int]]) -> int:
        min_dist = math.inf
        min_idx = -1

        for i, point in enumerate(points):
            px, py = point[0], point[1]

            if px == x or py == y:
                current_dist = abs(px - x) + abs(py - y)

                if current_dist < min_dist:
                    min_dist = current_dist
                    min_idx = i

        return min_idx