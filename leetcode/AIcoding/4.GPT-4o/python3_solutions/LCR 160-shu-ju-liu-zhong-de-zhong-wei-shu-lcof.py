import heapq

class MedianFinder:

    def __init__(self):
        self.max_heap = []  # Max-heap for the lower half
        self.min_heap = []  # Min-heap for the upper half

    def addNum(self, num: int) -> None:
        heapq.heappush(self.max_heap, -num)
        if self.max_heap and self.min_heap and (-self.max_heap[0] > self.min_heap[0]):
            value = -heapq.heappop(self.max_heap)
            heapq.heappush(self.min_heap, value)

        if len(self.max_heap) > len(self.min_heap) + 1:
            value = -heapq.heappop(self.max_heap)
            heapq.heappush(self.min_heap, value)
        elif len(self.min_heap) > len(self.max_heap):
            value = heapq.heappop(self.min_heap)
            heapq.heappush(self.max_heap, -value)

    def findMedian(self) -> float:
        if len(self.max_heap) > len(self.min_heap):
            return -self.max_heap[0]
        return (-self.max_heap[0] + self.min_heap[0]) / 2