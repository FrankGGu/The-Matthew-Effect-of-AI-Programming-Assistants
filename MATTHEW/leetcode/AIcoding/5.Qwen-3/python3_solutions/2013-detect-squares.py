class DetectSquares:

    def __init__(self):
        self.points = {}

    def add(self, point):
        x, y = point
        if (x, y) in self.points:
            self.points[(x, y)] += 1
        else:
            self.points[(x, y)] = 1

    def count(self, point):
        x, y = point
        res = 0
        for (px, py), cnt in self.points.items():
            if px == x or py == y:
                continue
            if (x, py) in self.points and (px, y) in self.points:
                res += cnt * self.points[(x, py)] * self.points[(px, y)]
        return res