class Solution:
    def maxPoints(self, points: List[List[int]]) -> int:
        m, n = len(points), len(points[0])
        for i in range(1, m):
            for j in range(n):
                max_val = 0
                for k in range(n):
                    if k != j:
                        max_val = max(max_val, points[i-1][k] - abs(j - k))
                points[i][j] += max_val
        return max(points[-1])