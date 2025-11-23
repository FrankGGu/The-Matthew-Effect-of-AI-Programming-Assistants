class Solution:
    def checkOverlap(self, radius: int, x_center: int, y_center: int, x1: int, y1: int, x2: int, y2: int) -> bool:
        # Find the closest point to the circle within the rectangle
        closest_x = max(x1, min(x_center, x2))
        closest_y = max(y1, min(y_center, y2))

        # Calculate the distance between the circle's center and this closest point
        distance_squared = (closest_x - x_center)**2 + (closest_y - y_center)**2

        # Check if the distance is less than or equal to the radius squared
        return distance_squared <= radius**2