import heapq

class SeatManager:

    def __init__(self, n: int):
        self.available_seats = []
        for i in range(1, n + 1):
            heapq.heappush(self.available_seats, i)

    def reserve(self) -> int:
        return heapq.heappop(self.available_seats)

    def unreserve(self, seatNumber: int) -> None:
        heapq.heappush(self.available_seats, seatNumber)