import math

class Solution:
    def coordinateWithMaxNetworkQuality(self, towers: list[list[int]], radius: int) -> list[int]:
        max_quality = 0
        best_coord = [0, 0]

        for bx in range(101):
            for by in range(101):
                current_quality = 0
                for tx, ty, q in towers:
                    distance_sq = (bx - tx)**2 + (by - ty)**2
                    distance = math.sqrt(distance_sq)

                    if distance <= radius:
                        tower_contribution = math.floor(q / (1 + distance))
                        current_quality += tower_contribution

                if current_quality > max_quality:
                    max_quality = current_quality
                    best_coord = [bx, by]

        return best_coord