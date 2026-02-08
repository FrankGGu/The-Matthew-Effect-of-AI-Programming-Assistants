import math
from collections import defaultdict

class Solution:
    def maxPoints(self, points: list[list[int]]) -> int:
        n = len(points)
        if n <= 2:
            return n

        max_overall_points = 0

        for i in range(n):
            p1 = points[i]

            slope_counts = defaultdict(int)
            duplicates = 1 
            max_points_for_p1_on_line = 0 

            for j in range(i + 1, n):
                p2 = points[j]

                if p1[0] == p2[0] and p1[1] == p2[1]:
                    duplicates += 1
                    continue

                dy = p2[1] - p1[1]
                dx = p2[0] - p1[0]

                if dx == 0:
                    slope = float('inf')
                elif dy == 0:
                    slope = 0.0
                else:
                    common_divisor = math.gcd(dy, dx)
                    normalized_dy = dy // common_divisor
                    normalized_dx = dx // common_divisor

                    if normalized_dx < 0:
                        normalized_dy = -normalized_dy
                        normalized_dx = -normalized_dx

                    slope = (normalized_dy, normalized_dx)

                slope_counts[slope] += 1
                max_points_for_p1_on_line = max(max_points_for_p1_on_line, slope_counts[slope])

            max_overall_points = max(max_overall_points, max_points_for_p1_on_line + duplicates)

        return max_overall_points