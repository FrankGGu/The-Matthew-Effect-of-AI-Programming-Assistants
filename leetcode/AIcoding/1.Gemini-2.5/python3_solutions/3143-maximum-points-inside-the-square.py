import collections

class Solution:
    def maxPointsInsideSquare(self, points: list[list[int]]) -> int:
        points_with_radii = []
        for x, y, point_type in points:
            r = max(abs(x), abs(y))
            points_with_radii.append((r, point_type))

        points_with_radii.sort()

        max_points = 0

        type_counts = collections.defaultdict(int)
        distinct_types_in_prefix = 0

        for i in range(len(points_with_radii)):
            r_current, type_current = points_with_radii[i]

            type_counts[type_current] += 1

            if type_counts[type_current] == 1:
                distinct_types_in_prefix += 1

            if distinct_types_in_prefix <= 1:
                max_points = max(max_points, i + 1)
            else:
                break

        return max_points