class Solution:
    def nearestValidPoint(self, x: int, y: int, points: List[List[int]]) -> int:
        min_distance = float('inf')
        index = -1
        for i, (a, b) in enumerate(points):
            if a == x or b == y:
                distance = abs(a - x) + abs(b - y)
                if distance < min_distance:
                    min_distance = distance
                    index = i
        return index