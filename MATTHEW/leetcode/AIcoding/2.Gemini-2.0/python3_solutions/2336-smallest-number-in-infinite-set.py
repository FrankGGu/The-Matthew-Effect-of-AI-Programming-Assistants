import heapq

class SmallestInfiniteSet:

    def __init__(self):
        self.present = set(range(1, 1001))
        self.heap = []

    def popSmallest(self) -> int:
        if self.heap:
            smallest = heapq.heappop(self.heap)
        else:
            smallest = min(self.present)
        self.present.discard(smallest)
        return smallest

    def addBack(self, num: int) -> None:
        if num not in self.present and num < 1001:
            if num < min(self.present) if self.present else True:
                heapq.heappush(self.heap, num)
            else:
                self.present.add(num)