import math

class Solution:
    def getMinDistSum(self, positions: list[list[int]]) -> float:
        def dist_sum(x, y):
            total_dist = 0
            for px, py in positions:
                total_dist += math.sqrt((x - px) ** 2 + (y - py) ** 2)
            return total_dist

        x_min = min(p[0] for p in positions)
        x_max = max(p[0] for p in positions)
        y_min = min(p[1] for p in positions)
        y_max = max(p[1] for p in positions)

        x = (x_min + x_max) / 2
        y = (y_min + y_max) / 2

        learning_rate = 0.1
        tolerance = 1e-7

        while learning_rate > tolerance:
            dx = 0
            dy = 0
            for px, py in positions:
                distance = math.sqrt((x - px) ** 2 + (y - py) ** 2)
                if distance > 0:
                    dx += (x - px) / distance
                    dy += (y - py) / distance
                else:
                    dx = 0
                    dy = 0
                    break

            new_x = x - learning_rate * dx
            new_y = y - learning_rate * dy

            if dist_sum(new_x, new_y) < dist_sum(x, y):
                x = new_x
                y = new_y
            else:
                learning_rate /= 2

        return dist_sum(x, y)