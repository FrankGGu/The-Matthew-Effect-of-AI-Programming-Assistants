import heapq

class DinnerPlates:

    def __init__(self, capacity: int):
        self.capacity = capacity
        self.stacks = []
        self.available = []
        self.non_empty = set()

    def push(self, val: int) -> None:
        if self.available:
            index = heapq.heappop(self.available)
            self.stacks[index].append(val)
            self.non_empty.add(index)
        else:
            if not self.stacks:
                self.stacks.append([val])
                self.non_empty.add(0)
            else:
                if len(self.stacks[-1]) < self.capacity:
                    self.stacks[-1].append(val)
                    self.non_empty.add(len(self.stacks) - 1)
                else:
                    self.stacks.append([val])
                    self.non_empty.add(len(self.stacks) - 1)

        while self.available and self.available[0] >= len(self.stacks):
            heapq.heappop(self.available)

    def pop(self) -> int:
        while self.stacks and not self.non_empty:
            self.stacks.pop()

        if not self.stacks:
            return -1

        while self.stacks and not self.stacks[-1]:
            self.stacks.pop()

        if not self.stacks:
            return -1

        val = self.stacks[-1].pop()

        if not self.stacks[-1]:
            self.non_empty.remove(len(self.stacks) - 1)

        return val

    def popAtStack(self, index: int) -> int:
        if index >= len(self.stacks) or not self.stacks[index]:
            return -1

        val = self.stacks[index].pop()
        if not self.stacks[index]:
            self.non_empty.discard(index)
            heapq.heappush(self.available, index)

        return val