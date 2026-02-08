import heapq

class SORTracker:

    def __init__(self):
        self.pq_small = []  # max heap
        self.pq_large = []  # min heap
        self.count = 0

    def add(self, name: str, score: int) -> None:
        heapq.heappush(self.pq_small, (-score, name))
        score, name = heapq.heappop(self.pq_small)
        heapq.heappush(self.pq_large, (score, name))

    def get(self) -> str:
        score, name = heapq.heappop(self.pq_large)
        heapq.heappush(self.pq_small, (-score, name))
        self.count += 1
        return name