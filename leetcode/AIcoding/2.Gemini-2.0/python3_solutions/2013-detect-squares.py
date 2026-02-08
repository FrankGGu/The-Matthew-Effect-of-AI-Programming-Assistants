class DetectSquares:

    def __init__(self):
        self.points = {}

    def add(self, point: list[int]) -> None:
        x, y = point
        if (x, y) in self.points:
            self.points[(x, y)] += 1
        else:
            self.points[(x, y)] = 1

    def count(self, point: list[int]) -> int:
        x, y = point
        count = 0
        for px, py in self.points:
            if px != x and py != y and abs(px - x) == abs(py - y):
                if (px, y) in self.points and (x, py) in self.points:
                    count += self.points[(px, py)] * self.points[(px, y)] * self.points[(x, py)]
        return count