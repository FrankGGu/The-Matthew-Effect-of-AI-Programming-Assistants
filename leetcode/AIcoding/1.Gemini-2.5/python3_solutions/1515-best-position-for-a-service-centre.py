import math

class Solution:
    def getMinDistSum(self, points: list[list[int]]) -> float:

        def calculate_total_distance(x, y, points_list):
            total_dist = 0.0
            for px, py in points_list:
                total_dist += math.sqrt((x - px)**2 + (y - py)**2)
            return total_dist

        num_points = len(points)

        if num_points == 1:
            return 0.0

        cx = sum(p[0] for p in points) / num_points
        cy = sum(p[1] for p in points) / num_points

        step = 100.0
        min_step = 1e-7

        directions = [
            (0, 1), (0, -1), (1, 0), (-1, 0),
            (1, 1), (1, -1), (-1, 1), (-1, -1)
        ]

        while step > min_step:
            found_better_in_this_iteration = False
            current_min_dist = calculate_total_distance(cx, cy, points)

            best_nx, best_ny = cx, cy

            for dx, dy in directions:
                nx = cx + dx * step
                ny = cy + dy * step

                new_dist = calculate_total_distance(nx, ny, points)

                if new_dist < current_min_dist:
                    current_min_dist = new_dist
                    best_nx, best_ny = nx, ny
                    found_better_in_this_iteration = True

            if found_better_in_this_iteration:
                cx, cy = best_nx, best_ny
            else:
                step /= 10.0

        return calculate_total_distance(cx, cy, points)