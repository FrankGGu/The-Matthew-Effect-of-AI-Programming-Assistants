class Solution:
    def circleGame(self, toys: list[list[int]], circles: list[list[int]], r: int) -> int:
        count = 0
        for toy in toys:
            toy_x, toy_y, toy_radius = toy
            is_covered = False
            for circle in circles:
                circle_x, circle_y = circle
                distance = ((toy_x - circle_x)**2 + (toy_y - circle_y)**2)**0.5
                if distance + toy_radius <= r:
                    is_covered = True
                    break
            if is_covered:
                count += 1
        return count