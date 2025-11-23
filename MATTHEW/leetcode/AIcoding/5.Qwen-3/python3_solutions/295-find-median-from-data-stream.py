import heapq

class MedianFinder:

    def __init__(self):
        self.left_max_heap = []  # max heap (using negative values)
        self.right_min_heap = []  # min heap

    def addNum(self, num: int) -> None:
        if not self.left_max_heap or num <= -self.left_max_heap[0]:
            heapq.heappush(self.left_max_heap, -num)
        else:
            heapq.heappush(self.right_min_heap, num)

        # Balance the heaps
        if len(self.left_max_heap) > len(self.right_min_heap) + 1:
            val = -heapq.heappop(self.left_max_heap)
            heapq.heappush(self.right_min_heap, val)
        elif len(self.right_min_heap) > len(self.left_max_heap):
            val = heapq.heappop(self.right_min_heap)
            heapq.heappush(self.left_max_heap, -val)

    def findMedian(self) -> float:
        if len(self.left_max_heap) == len(self.right_min_heap):
            return (-self.left_max_heap[0] + self.right_min_heap[0]) / 2
        else:
            return -self.left_max_heap[0]