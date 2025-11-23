class Solution:
    def bestCoordinate(self, towers: List[List[int]], radius: int) -> List[int]:
        max_quality = 0
        best_coordinate = [0, 0]

        for x in range(101):
            for y in range(101):
                quality = 0
                for tx, ty, q in towers:
                    dist = max(abs(tx - x), abs(ty - y))
                    if dist <= radius:
                        quality += q * (1 - dist / radius)
                if quality > max_quality:
                    max_quality = quality
                    best_coordinate = [x, y]

        return best_coordinate