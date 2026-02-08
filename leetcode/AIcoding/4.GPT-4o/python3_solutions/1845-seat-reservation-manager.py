class SeatManager:

    def __init__(self, n: int):
        self.available = set(range(1, n + 1))

    def reserve(self) -> int:
        seat = min(self.available)
        self.available.remove(seat)
        return seat

    def unreserve(self, seatNumber: int) -> None:
        self.available.add(seatNumber)