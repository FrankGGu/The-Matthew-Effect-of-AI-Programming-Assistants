import math

class Solution:
    def minimizeManhattanDistance(self, points: list[list[int]]) -> int:
        n = len(points)

        u_coords = []
        v_coords = []
        for i in range(n):
            x, y = points[i]
            u_coords.append((x + y, i))
            v_coords.append((x - y, i))

        u_coords.sort()
        v_coords.sort()

        min_overall_max_dist = math.inf

        for k in range(n):
            new_min_u = math.inf
            new_max_u = -math.inf

            if u_coords[0][1] == k:
                new_min_u = u_coords[1][0]
            else:
                new_min_u = u_coords[0][0]

            if u_coords[-1][1] == k:
                new_max_u = u_coords[-2][0]
            else:
                new_max_u = u_coords[-1][0]

            new_min_v = math.inf
            new_max_v = -math.inf

            if v_coords[0][1] == k:
                new_min_v = v_coords[1][0]
            else:
                new_min_v = v_coords[0][0]

            if v_coords[-1][1] == k:
                new_max_v = v_coords[-2][0]
            else:
                new_max_v = v_coords[-1][0]

            current_max_dist = max(new_max_u - new_min_u, new_max_v - new_min_v)

            min_overall_max_dist = min(min_overall_max_dist, current_max_dist)

        return min_overall_max_dist