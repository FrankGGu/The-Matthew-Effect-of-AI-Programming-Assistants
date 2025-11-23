class BookMyShow:

    def __init__(self, n: int, m: int):
        self.seats = [0] * n
        self.total_seats = m
        self.total_rows = n

    def gather(self, k: int, maxRow: int) -> List[int]:
        for i in range(min(maxRow + 1, self.total_rows)):
            if self.seats[i] + k <= self.total_seats:
                self.seats[i] += k
                return [i, self.seats[i] - k]
        return [-1, -1]

    def scatter(self, k: int) -> bool:
        for i in range(self.total_rows):
            if self.seats[i] + k <= self.total_seats:
                self.seats[i] += k
                return True
        return False