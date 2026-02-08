import random
import math

class Solution:

    def __init__(self, radius: float, x_center: float, y_center: float):
        self.radius = radius
        self.x_center = x_center
        self.y_center = y_center

    def randPoint(self) -> List[float]:
        while True:
            x = random.uniform(-self.radius, self.radius)
            y = random.uniform(-self.radius, self.radius)
            if x**2 + y**2 <= self.radius**2:
                return [self.x_center + x, self.y_center + y]