import heapq

class SORTracker:

    def __init__(self):
        self.min_heap = []
        self.max_heap = []
        self.query_count = 0

    def add(self, name: str, score: int) -> None:
        heapq.heappush(self.max_heap, (-score, name))
        neg_score, name = heapq.heappop(self.max_heap)
        heapq.heappush(self.min_heap, (-neg_score, name))

    def get(self) -> str:
        self.query_count += 1
        score, name = heapq.heappop(self.min_heap)
        heapq.heappush(self.max_heap, (-score, name))
        return name