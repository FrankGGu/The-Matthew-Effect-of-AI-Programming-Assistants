import heapq

class MedianFinder:

    def __init__(self):
        """
        initialize your data structure here.
        """
        # max_heap (left_heap): stores the smaller half of the numbers.
        # We use a min-heap in Python by storing negative values.
        self.left_heap = [] 

        # min_heap (right_heap): stores the larger half of the numbers.
        self.right_heap = []

    def addNum(self, num: int) -> None:
        # Step 1: Add the number to one of the heaps
        # If left_heap is empty or the number is less than or equal to the largest element in left_heap,
        # add it to left_heap. Otherwise, add it to right_heap.
        if not self.left_heap or num <= -self.left_heap[0]:
            heapq.heappush(self.left_heap, -num)
        else:
            heapq.heappush(self.right_heap, num)

        # Step 2: Balance the heaps
        # Maintain the invariant: len(left_heap) is either len(right_heap) or len(right_heap) + 1.
        # This ensures that the median is always easily accessible.

        # If left_heap has too many elements (more than right_heap + 1), move its largest to right_heap.
        if len(self.left_heap) > len(self.right_heap) + 1:
            val = -heapq.heappop(self.left_heap)
            heapq.heappush(self.right_heap, val)
        # If right_heap has more elements than left_heap, move its smallest to left_heap.
        elif len(self.right_heap) > len(self.left_heap):
            val = heapq.heappop(self.right_heap)
            heapq.heappush(self.left_heap, -val)

    def findMedian(self) -> float:
        # If the total number of elements is odd, the median is the largest element in left_heap.
        if len(self.left_heap) > len(self.right_heap):
            return float(-self.left_heap[0])
        # If the total number of elements is even, the median is the average of the largest in left_heap
        # and the smallest in right_heap.
        elif len(self.left_heap) == len(self.right_heap):
            return (-self.left_heap[0] + self.right_heap[0]) / 2.0
        # This case (len(self.right_heap) > len(self.left_heap)) should not be reached
        # due to the balancing logic in addNum, assuming findMedian is called after at least one addNum.
        # If it could be reached (e.g., empty stream), it would imply an error or specific problem handling.
        # For LeetCode, we assume valid calls.
        return 0.0 # Should not be reached in typical LeetCode scenarios