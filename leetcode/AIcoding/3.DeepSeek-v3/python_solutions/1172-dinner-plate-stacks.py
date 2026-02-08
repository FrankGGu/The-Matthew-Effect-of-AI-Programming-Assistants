class DinnerPlates:

    def __init__(self, capacity: int):
        self.capacity = capacity
        self.stacks = []
        self.available = []

    def push(self, val: int) -> None:
        if self.available:
            index = heapq.heappop(self.available)
            if index < len(self.stacks):
                self.stacks[index].append(val)
                if len(self.stacks[index]) < self.capacity:
                    heapq.heappush(self.available, index)
                return
            else:
                while self.available and self.available[0] >= len(self.stacks):
                    heapq.heappop(self.available)
        if not self.stacks or len(self.stacks[-1]) == self.capacity:
            self.stacks.append([])
        self.stacks[-1].append(val)
        if len(self.stacks[-1]) < self.capacity:
            heapq.heappush(self.available, len(self.stacks) - 1

    def pop(self) -> int:
        while self.stacks and not self.stacks[-1]:
            self.stacks.pop()
        if not self.stacks:
            return -1
        return self.stacks[-1].pop()

    def popAtStack(self, index: int) -> int:
        if index >= len(self.stacks) or not self.stacks[index]:
            return -1
        val = self.stacks[index].pop()
        heapq.heappush(self.available, index)
        return val