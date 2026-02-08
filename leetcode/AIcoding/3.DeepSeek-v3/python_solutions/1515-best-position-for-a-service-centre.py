import math

class Solution:
    def getMinDistSum(self, positions: List[List[int]]) -> float:
        def compute_total_distance(x, y):
            total = 0.0
            for px, py in positions:
                dx = x - px
                dy = y - py
                total += math.sqrt(dx * dx + dy * dy)
            return total

        left = 0.0
        right = 100.0
        bottom = 0.0
        top = 100.0

        min_distance = float('inf')
        best_x, best_y = 0.0, 0.0

        for _ in range(100):
            mid_x1 = left + (right - left) / 3
            mid_x2 = right - (right - left) / 3
            for __ in range(100):
                mid_y1 = bottom + (top - bottom) / 3
                mid_y2 = top - (top - bottom) / 3

                d1 = compute_total_distance(mid_x1, mid_y1)
                d2 = compute_total_distance(mid_x1, mid_y2)
                d3 = compute_total_distance(mid_x2, mid_y1)
                d4 = compute_total_distance(mid_x2, mid_y2)

                current_min = min(d1, d2, d3, d4)
                if current_min < min_distance:
                    min_distance = current_min
                    if current_min == d1:
                        best_x, best_y = mid_x1, mid_y1
                    elif current_min == d2:
                        best_x, best_y = mid_x1, mid_y2
                    elif current_min == d3:
                        best_x, best_y = mid_x2, mid_y1
                    else:
                        best_x, best_y = mid_x2, mid_y2

                if d1 < d2:
                    top = mid_y2
                else:
                    bottom = mid_y1

            if compute_total_distance(mid_x1, best_y) < compute_total_distance(mid_x2, best_y):
                right = mid_x2
            else:
                left = mid_x1

        return min_distance