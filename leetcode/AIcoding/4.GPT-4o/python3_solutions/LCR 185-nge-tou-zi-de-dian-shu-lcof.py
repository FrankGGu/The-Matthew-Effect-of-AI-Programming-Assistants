class Solution:
    def getProb(self, points: List[List[int]]) -> float:
        total_points = sum(p[0] * p[1] for p in points)
        return sum(p[0] * p[1] / total_points for p in points)