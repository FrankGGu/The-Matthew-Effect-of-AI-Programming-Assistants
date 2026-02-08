class StockPrice:

    def __init__(self):
        self.time_price = {}
        self.current_time = 0
        self.max_time = 0

    def update(self, timestamp: int, price: int) -> None:
        self.time_price[timestamp] = price
        self.current_time = max(self.current_time, timestamp)

    def current(self) -> int:
        return self.time_price[self.current_time]

    def maximum(self) -> int:
        return max(self.time_price.values())

    def minimum(self) -> int:
        return min(self.time_price.values())