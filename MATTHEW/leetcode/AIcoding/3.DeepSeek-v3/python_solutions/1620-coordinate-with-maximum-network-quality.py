import math

class Solution:
    def bestCoordinate(self, towers: List[List[int]], radius: int) -> List[int]:
        max_quality = -1
        best_coord = [0, 0]

        min_x = min(t[0] for t in towers)
        max_x = max(t[0] for t in towers)
        min_y = min(t[1] for t in towers)
        max_y = max(t[1] for t in towers)

        for x in range(min_x, max_x + 1):
            for y in range(min_y, max_y + 1):
                total_quality = 0
                for tx, ty, q in towers:
                    d = math.sqrt((x - tx)**2 + (y - ty)**2)
                    if d <= radius:
                        total_quality += int(q / (1 + d))
                if total_quality > max_quality:
                    max_quality = total_quality
                    best_coord = [x, y]
                elif total_quality == max_quality:
                    if x < best_coord[0] or (x == best_coord[0] and y < best_coord[1]):
                        best_coord = [x, y]

        return best_coord