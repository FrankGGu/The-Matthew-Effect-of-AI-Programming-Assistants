class Solution:
    def bestCoordinate(self, towers: List[List[int]], radius: int) -> List[int]:
        max_x = max(t[0] for t in towers)
        max_y = max(t[1] for t in towers)
        max_quality = 0
        best_coord = [0, 0]

        for x in range(max_x + 1):
            for y in range(max_y + 1):
                quality = 0
                for tower_x, tower_y, strength in towers:
                    dist = ((x - tower_x) ** 2 + (y - tower_y) ** 2) ** 0.5
                    if dist <= radius:
                        quality += int(strength / (1 + dist))

                if quality > max_quality:
                    max_quality = quality
                    best_coord = [x, y]

        return best_coord