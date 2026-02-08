class Solution:
    def checkOverlap(self, radius: int, x_center: int, y_center: int, x1: int, y1: int, x2: int, y2: int) -> bool:

        closest_x = max(x1, min(x_center, x2))
        closest_y = max(y1, min(y_center, y2))

        dist_x = x_center - closest_x
        dist_y = y_center - closest_y

        distance_squared = (dist_x * dist_x) + (dist_y * dist_y)

        return distance_squared <= (radius * radius)