import heapq

class MKAverage:

    def __init__(self, m: int, k: int):
        self.m = m
        self.k = k
        self.queue = []
        self.small = []
        self.large = []
        self.middle = []
        self.small_sum = 0
        self.large_sum = 0
        self.total_sum = 0
        self.small_size = 0
        self.large_size = 0
        self.middle_size = 0

    def addElement(self, num: int) -> None:
        if len(self.queue) == self.m:
            removed = self.queue.pop(0)
            if removed in self.small:
                self.small.remove(removed)
                self.small_size -= 1
                self.small_sum -= removed
            elif removed in self.large:
                self.large.remove(removed)
                self.large_size -= 1
                self.large_sum -= removed
            else:
                self.middle.remove(removed)
                self.middle_size -= 1
                self.total_sum -= removed
        self.queue.append(num)
        heapq.heappush(self.middle, num)
        self.middle_size += 1
        self.total_sum += num
        if self.middle_size > 0 and (self.small_size < self.k or num < -self.small[0]):
            val = heapq.heappop(self.middle)
            self.middle_size -= 1
            self.total_sum -= val
            heapq.heappush(self.small, -val)
            self.small_size += 1
            self.small_sum += val
        elif self.middle_size > 0 and (self.large_size < self.k or num > self.large[0]):
            val = heapq.heappop(self.middle)
            self.middle_size -= 1
            self.total_sum -= val
            heapq.heappush(self.large, val)
            self.large_size += 1
            self.large_sum += val
        if self.small_size > self.k:
            val = -heapq.heappop(self.small)
            self.small_size -= 1
            self.small_sum -= val
            heapq.heappush(self.middle, val)
            self.middle_size += 1
            self.total_sum += val
        if self.large_size > self.k:
            val = heapq.heappop(self.large)
            self.large_size -= 1
            self.large_sum -= val
            heapq.heappush(self.middle, val)
            self.middle_size += 1
            self.total_sum += val

    def calculateMKAverage(self) -> int:
        if len(self.queue) < self.m:
            return -1
        return self.total_sum // (self.m - 2 * self.k)