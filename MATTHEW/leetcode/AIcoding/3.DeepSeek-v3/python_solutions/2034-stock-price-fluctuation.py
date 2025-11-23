import heapq

class StockPrice:

    def __init__(self):
        self.timestamps = {}
        self.latest_time = 0
        self.min_heap = []
        self.max_heap = []

    def update(self, timestamp: int, price: int) -> None:
        self.timestamps[timestamp] = price
        self.latest_time = max(self.latest_time, timestamp)
        heapq.heappush(self.min_heap, (price, timestamp))
        heapq.heappush(self.max_heap, (-price, timestamp))

    def current(self) -> int:
        return self.timestamps[self.latest_time]

    def maximum(self) -> int:
        while self.max_heap:
            price, timestamp = self.max_heap[0]
            if self.timestamps[timestamp] == -price:
                return -price
            heapq.heappop(self.max_heap)
        return -1

    def minimum(self) -> int:
        while self.min_heap:
            price, timestamp = self.min_heap[0]
            if self.timestamps[timestamp] == price:
                return price
            heapq.heappop(self.min_heap)
        return -1