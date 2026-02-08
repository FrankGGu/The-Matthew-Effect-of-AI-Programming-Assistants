class Solution:
    def minDistance(self, points1: List[List[int]], points2: List[List[int]]) -> int:
        return sum(abs(x1 - x2) + abs(y1 - y2) for (x1, y1), (x2, y2) in zip(points1, points2))