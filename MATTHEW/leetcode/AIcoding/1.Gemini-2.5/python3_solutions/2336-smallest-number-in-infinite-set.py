import heapq

class SmallestInfiniteSet:

    def __init__(self):
        self.current_smallest = 1
        self.added_back_heap = []
        self.added_back_set = set()

    def popSmallest(self) -> int:
        if self.added_back_heap and self.added_back_heap[0] < self.current_smallest:
            res = heapq.heappop(self.added_back_heap)
            self.added_back_set.remove(res)
            return res
        else:
            res = self.current_smallest
            self.current_smallest += 1
            return res

    def addBack(self, num: int) -> None:
        if num < self.current_smallest and num not in self.added_back_set:
            heapq.heappush(self.added_back_heap, num)
            self.added_back_set.add(num)