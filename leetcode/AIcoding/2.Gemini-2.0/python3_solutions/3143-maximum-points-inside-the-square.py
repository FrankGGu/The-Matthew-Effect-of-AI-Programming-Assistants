class Solution:
    def maxPointsInsideSquare(self, points: list[list[int]], side: int) -> int:
        n = len(points)
        ans = 0
        for i in range(n):
            for j in range(n):
                x1 = points[i][0]
                y1 = points[j][1]
                count = 0
                for k in range(n):
                    x, y = points[k]
                    if x1 <= x <= x1 + side and y1 <= y <= y1 + side:
                        count += 1
                ans = max(ans, count)
        return ans