class BookMyShow:

    def __init__(self, n: int, m: int):
        self.n = n
        self.m = m
        self.seats = [m] * n
        self.prefix_sum = [0] * (n + 1)
        for i in range(n):
            self.prefix_sum[i+1] = self.prefix_sum[i] + m

    def gather(self, k: int, maxRow: int) -> list[int]:
        for i in range(min(maxRow + 1, self.n)):
            if self.seats[i] >= k:
                row = i
                col = self.m - self.seats[i]
                self.seats[i] -= k
                return [row, col]
        return []

    def scatter(self, k: int, maxRow: int) -> bool:
        remaining = k
        total_available = self.prefix_sum[min(maxRow + 1, self.n)] - sum(self.m - seat for seat in self.seats[:min(maxRow + 1, self.n)])

        if total_available < k:
            return False

        for i in range(min(maxRow + 1, self.n)):
            available = self.seats[i]
            if available > 0:
                take = min(available, remaining)
                self.seats[i] -= take
                remaining -= take
                if remaining == 0:
                    return True

        return remaining == 0