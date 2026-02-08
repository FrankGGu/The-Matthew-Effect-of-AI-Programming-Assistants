class ExamRoom:

    def __init__(self, N: int):
        self.N = N
        self.seats = []

    def seat(self) -> int:
        if not self.seats:
            self.seats.append(0)
            return 0
        max_dist = self.seats[0]
        pos = 0
        for i in range(1, len(self.seats)):
            dist = (self.seats[i] - self.seats[i-1]) // 2
            if dist > max_dist:
                max_dist = dist
                pos = (self.seats[i] + self.seats[i-1]) // 2
        last_dist = self.N - 1 - self.seats[-1]
        if last_dist > max_dist:
            pos = self.N - 1
        import bisect
        bisect.insort(self.seats, pos)
        return pos

    def leave(self, p: int) -> None:
        self.seats.remove(p)