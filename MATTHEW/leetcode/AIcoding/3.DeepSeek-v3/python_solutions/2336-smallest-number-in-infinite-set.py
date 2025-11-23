import heapq

class SmallestInfiniteSet:

    def __init__(self):
        self.current_min = 1
        self.added_back = []
        self.added_set = set()

    def popSmallest(self) -> int:
        if self.added_back:
            smallest = heapq.heappop(self.added_back)
            self.added_set.remove(smallest)
            return smallest
        else:
            smallest = self.current_min
            self.current_min += 1
            return smallest

    def addBack(self, num: int) -> None:
        if num < self.current_min and num not in self.added_set:
            heapq.heappush(self.added_back, num)
            self.added_set.add(num)