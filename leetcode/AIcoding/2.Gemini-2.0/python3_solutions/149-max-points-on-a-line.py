from collections import defaultdict

class Solution:
    def maxPoints(self, points: list[list[int]]) -> int:
        n = len(points)
        if n <= 2:
            return n

        max_points = 0

        for i in range(n):
            slopes = defaultdict(int)
            same_point = 1

            for j in range(i + 1, n):
                if points[i][0] == points[j][0] and points[i][1] == points[j][1]:
                    same_point += 1
                else:
                    dx = points[j][0] - points[i][0]
                    dy = points[j][1] - points[i][1]

                    def gcd(a, b):
                        while b:
                            a, b = b, a % b
                        return a

                    g = gcd(dx, dy)
                    dx //= g
                    dy //= g

                    slopes[(dx, dy)] += 1

            max_points = max(max_points, same_point)
            for slope_count in slopes.values():
                max_points = max(max_points, slope_count + same_point)

        return max_points