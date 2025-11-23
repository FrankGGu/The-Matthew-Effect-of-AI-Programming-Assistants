from bisect import bisect_left, insort
from collections import defaultdict

class DinnerPlates:

    def __init__(self, capacity: int):
        self.capacity = capacity
        self.stacks = []
        self.available = []

    def push(self, val: int) -> None:
        if not self.available:
            self.stacks.append([val])
            return
        idx = self.available[0]
        self.stacks[idx].append(val)
        if len(self.stacks[idx]) == self.capacity:
            self.available.pop(0)
        else:
            return

    def pop(self) -> int:
        while self.stacks and not self.stacks[-1]:
            self.stacks.pop()
        if not self.stacks:
            return -1
        val = self.stacks[-1].pop()
        if len(self.stacks[-1]) < self.capacity:
            insort(self.available, len(self.stacks) - 1)
        return val

    def popAtStack(self, index: int) -> int:
        if index >= len(self.stacks) or not self.stacks[index]:
            return -1
        val = self.stacks[index].pop()
        insort(self.available, index)
        return val