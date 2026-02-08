import collections
import heapq

class MKAverage:

    def __init__(self, m: int, k: int):
        self.m = m
        self.k = k
        self.q = collections.deque()

        self.h_small = []  # Max-heap for the k smallest elements (stores -val)
        self.h_mid = []    # Min-heap for the m - 2k middle elements
        self.h_large = []  # Min-heap for the k largest elements

        self.sum_mid = 0   # Sum of elements in h_mid

        self.removed = collections.Counter() # Lazy deletion for elements removed from window

    def _clean_heap(self, heap, is_max_heap):
        # Removes elements from the top of the heap if they are marked as removed
        while heap and self.removed[abs(heap[0])] > 0:
            val = abs(heapq.heappop(heap))
            self.removed[val] -= 1
            if heap is self.h_mid:
                self.sum_mid -= val

    def _move(self, from_heap, from_is_max_heap, to_heap, to_is_max_heap):
        # Moves the top element from from_heap to to_heap
        val = abs(heapq.heappop(from_heap))
        if from_heap is self.h_mid:
            self.sum_mid -= val

        heapq.heappush(to_heap, -val if to_is_max_heap else val)

        if to_heap is self.h_mid:
            self.sum_mid += val

    def _balance(self):
        # Balances the three heaps to maintain correct sizes and order
        while True:
            # Clean all heaps at the start of each iteration
            self._clean_heap(self.h_small, True)
            self._clean_heap(self.h_mid, False)
            self._clean_heap(self.h_large, False)

            moved = False

            # Phase 1: Ensure correct sizes for h_small, h_mid, and h_large

            # h_small should have k elements
            while len(self.h_small) < self.k and self.h_mid:
                self._move(self.h_mid, False, self.h_small, True)
                moved = True
                self._clean_heap(self.h_mid, False)
                self._clean_heap(self.h_small, True)

            # h_large should have k elements
            while len(self.h_large) < self.k and self.h_mid:
                self._move(self.h_mid, False, self.h_large, False)
                moved = True
                self._clean_heap(self.h_mid, False)
                self._clean_heap(self.h_large, False)

            # h_small should not exceed k elements
            while len(self.h_small) > self.k:
                self._move(self.h_small, True, self.h_mid, False)
                moved = True
                self._clean_heap(self.h_small, True)
                self._clean_heap(self.h_mid, False)

            # h_large should not exceed k elements
            while len(self.h_large) > self.k:
                self._move(self.h_large, False, self.h_mid, False)
                moved = True
                self._clean_heap(self.h_large, False)
                self._clean_heap(self.h_mid, False)

            # h_mid should not exceed m - 2k elements
            while len(self.h_mid) > self.m - 2 * self.k:
                self._move(self.h_mid, False, self.h_large, False)
                moved = True
                self._clean_heap(self.h_mid, False)
                self._clean_heap(self.h_large, False)

            # Phase 2: Ensure correct order (max(h_small) <= min(h_mid) <= min(h_large))

            # If max of h_small is greater than min of h_mid, swap them
            if self.h_small and self.h_mid and -self.h_small[0] > self.h_mid[0]:
                self._move(self.h_small, True, self.h_mid, False)
                self._move(self.h_mid, False, self.h_small, True)
                moved = True
                self._clean_heap(self.h_small, True)
                self._clean_heap(self.h_mid, False)

            # If min of h_mid is greater than min of h_large, swap them
            if self.h_mid and self.h_large and self.h_mid[0] > self.h_large[0]:
                self._move(self.h_mid, False, self.h_large, False)
                self._move(self.h_large, False, self.h_mid, False)
                moved = True
                self._clean_heap(self.h_mid, False)
                self._clean_heap(self.h_large, False)

            if not moved:
                break # No more changes, state is stable

    def addElement(self, num: int) -> None:
        self.q.append(num)

        # Initially add num to h_small. _balance() will move it to the correct heap.
        heapq.heappush(self.h_small, -num)

        # If window size exceeds m, remove the oldest element
        if len(self.q) > self.m:
            old_num = self.q.popleft()
            self.removed[old_num] += 1 # Mark for lazy deletion

        self._balance()

    def calculateMKAverage(self) -> int:
        if len(self.q) < self.m:
            return -1

        # Ensure heaps are clean and balanced before calculating
        self._balance()

        # The problem guarantees k * 2 < m, so m - 2k > 0, meaning h_mid will not be empty
        return self.sum_mid // (self.m - 2 * self.k)