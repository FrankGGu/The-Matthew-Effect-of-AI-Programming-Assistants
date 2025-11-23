class StockPrice:

    def __init__(self):
        self.prices = {}
        self.max_timestamp = 0
        self.min_heap = []
        self.max_heap = []

    def update(self, timestamp: int, price: int) -> None:
        self.prices[timestamp] = price
        self.max_timestamp = max(self.max_timestamp, timestamp)
        heapq.heappush(self.min_heap, (price, timestamp))
        heapq.heappush(self.max_heap, (-price, timestamp))

    def current(self) -> int:
        return self.prices[self.max_timestamp]

    def maximum(self) -> int:
        while self.max_heap and -self.max_heap[0][0] != self.prices[self.max_heap[0][1]]:
            heapq.heappop(self.max_heap)
        return -self.max_heap[0][0]

    def minimum(self) -> int:
        while self.min_heap and self.min_heap[0][0] != self.prices[self.min_heap[0][1]]:
            heapq.heappop(self.min_heap)
        return self.min_heap[0][0]

import heapq