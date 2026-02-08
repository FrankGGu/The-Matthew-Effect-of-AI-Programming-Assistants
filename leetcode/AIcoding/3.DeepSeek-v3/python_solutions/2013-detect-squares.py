from collections import defaultdict

class DetectSquares:

    def __init__(self):
        self.points = defaultdict(int)
        self.x_coords = defaultdict(list)

    def add(self, point: List[int]) -> None:
        x, y = point
        self.points[(x, y)] += 1
        self.x_coords[x].append(y)

    def count(self, point: List[int]) -> int:
        x1, y1 = point
        res = 0
        for y2 in self.x_coords[x1]:
            if y2 == y1:
                continue
            side = abs(y2 - y1)
            for x3 in [x1 - side, x1 + side]:
                y3 = y2
                x4, y4 = x3, y1
                res += self.points.get((x3, y3), 0) * self.points.get((x4, y4), 0)
        return res