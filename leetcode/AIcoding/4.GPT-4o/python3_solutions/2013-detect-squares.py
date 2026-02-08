class DetectSquares:

    def __init__(self):
        self.points = defaultdict(int)

    def add(self, point: List[int]) -> None:
        self.points[tuple(point)] += 1

    def count(self, point: List[int]) -> int:
        x, y = point
        count = 0
        for (px, py), freq in self.points.items():
            if px != x and abs(px - x) == abs(py - y):
                count += freq * self.points.get((x, py), 0)
        return count