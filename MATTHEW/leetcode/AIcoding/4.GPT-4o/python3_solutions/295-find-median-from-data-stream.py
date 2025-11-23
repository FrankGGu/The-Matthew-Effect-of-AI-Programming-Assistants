import heapq

class MedianFinder:

    def __init__(self):
        self.min_heap = []  # right half
        self.max_heap = []  # left half

    def addNum(self, num: int) -> None:
        heapq.heappush(self.max_heap, -num)
        if self.max_heap and (-self.max_heap[0] > self.min_heap[0] if self.min_heap else float('inf')):
            heapq.heappush(self.min_heap, -heapq.heappop(self.max_heap))

        if len(self.max_heap) < len(self.min_heap):
            heapq.heappush(self.max_heap, -heapq.heappop(self.min_heap))

    def findMedian(self) -> float:
        if len(self.max_heap) > len(self.min_heap):
            return -self.max_heap[0]
        return (-self.max_heap[0] + self.min_heap[0]) / 2