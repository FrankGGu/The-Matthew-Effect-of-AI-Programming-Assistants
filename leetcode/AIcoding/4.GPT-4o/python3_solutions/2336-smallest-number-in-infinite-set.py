class SmallestInfiniteSet:

    def __init__(self):
        self.available = set()
        self.next_num = 1

    def popSmallest(self) -> int:
        if self.available:
            smallest = min(self.available)
            self.available.remove(smallest)
            return smallest
        else:
            smallest = self.next_num
            self.next_num += 1
            return smallest

    def addBack(self, num: int) -> None:
        if num < self.next_num:
            self.available.add(num)