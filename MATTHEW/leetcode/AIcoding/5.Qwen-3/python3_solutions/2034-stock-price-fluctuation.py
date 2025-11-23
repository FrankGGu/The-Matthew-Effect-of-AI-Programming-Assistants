class StockPrice:
    def __init__(self):
        self.price_map = {}
        self.max_heap = []
        self.min_heap = []
        self.current_price = 0

    def update(self, timestamp: int, price: int) -> None:
        self.price_map[timestamp] = price
        self.current_price = price
        heapq.heappush(self.max_heap, (-price, timestamp))
        heapq.heappush(self.min_heap, (price, timestamp))

    def current(self) -> int:
        return self.current_price

    def maximum(self) -> int:
        while self.max_heap:
            neg_price, timestamp = self.max_heap[0]
            price = -neg_price
            if self.price_map.get(timestamp, None) == price:
                return price
            else:
                heapq.heappop(self.max_heap)
        return -1

    def minimum(self) -> int:
        while self.min_heap:
            price, timestamp = self.min_heap[0]
            if self.price_map.get(timestamp, None) == price:
                return price
            else:
                heapq.heappop(self.min_heap)
        return -1