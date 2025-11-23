import heapq
import collections

class StockPrice:

    def __init__(self):
        self.prices = {}
        self.latest_timestamp = 0
        self.min_heap = []
        self.max_heap = []
        self.price_counts = collections.Counter()

    def update(self, timestamp: int, price: int) -> None:
        if timestamp in self.prices:
            old_price = self.prices[timestamp]
            self.price_counts[old_price] -= 1

        self.prices[timestamp] = price
        self.latest_timestamp = max(self.latest_timestamp, timestamp)

        self.price_counts[price] += 1
        heapq.heappush(self.min_heap, price)
        heapq.heappush(self.max_heap, -price)

    def current(self) -> int:
        return self.prices[self.latest_timestamp]

    def maximum(self) -> int:
        while self.price_counts[-self.max_heap[0]] == 0:
            heapq.heappop(self.max_heap)
        return -self.max_heap[0]

    def minimum(self) -> int:
        while self.price_counts[self.min_heap[0]] == 0:
            heapq.heappop(self.min_heap)
        return self.min_heap[0]