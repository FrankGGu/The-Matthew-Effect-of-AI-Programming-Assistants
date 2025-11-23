from collections import deque
import sortedcontainers

class MKAverage:

    def __init__(self, m: int, k: int):
        self.m = m
        self.k = k
        self.stream = deque()
        self.sorted_window = sortedcontainers.SortedList()

    def addElement(self, num: int) -> None:
        if len(self.stream) == self.m:
            removed = self.stream.popleft()
            self.sorted_window.remove(removed)
        self.stream.append(num)
        self.sorted_window.add(num)

    def calculateMKAverage(self) -> int:
        if len(self.stream) < self.m:
            return -1
        return sum(self.sorted_window[self.k:self.m - self.k]) // (self.m - 2 * self.k)