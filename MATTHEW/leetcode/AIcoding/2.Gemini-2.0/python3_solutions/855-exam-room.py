class ExamRoom:

    def __init__(self, n: int):
        self.n = n
        self.seats = []

    def seat(self) -> int:
        if not self.seats:
            seat = 0
        else:
            max_dist = self.seats[0]
            seat = 0
            for i in range(1, len(self.seats)):
                dist = (self.seats[i] - self.seats[i - 1]) // 2
                if dist > max_dist:
                    max_dist = dist
                    seat = self.seats[i - 1] + dist
            if self.n - 1 - self.seats[-1] > max_dist:
                seat = self.n - 1
            elif self.n - 1 - self.seats[-1] == max_dist and seat != self.n - 1:
                pass
            elif self.seats[0] > max_dist:
                seat = 0

        import bisect
        bisect.insort(self.seats, seat)
        return seat

    def leave(self, p: int) -> None:
        self.seats.remove(p)