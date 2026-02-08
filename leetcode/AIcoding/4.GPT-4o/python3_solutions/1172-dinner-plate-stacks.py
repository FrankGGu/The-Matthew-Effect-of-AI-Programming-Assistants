class DinnerPlates:

    def __init__(self, capacity: int):
        self.capacity = capacity
        self.stacks = []
        self.available = []

    def push(self, val: int) -> None:
        if self.available:
            idx = self.available[0]
            self.stacks[idx].append(val)
            if len(self.stacks[idx]) == self.capacity:
                self.available.pop(0)
        else:
            self.stacks.append([val])
            if len(self.stacks) > 0 and len(self.stacks[-1]) == self.capacity:
                self.available.append(len(self.stacks) - 1)

    def pop(self) -> int:
        while self.stacks:
            if self.stacks[-1]:
                return self.stacks[-1].pop()
            self.stacks.pop()
        return -1

    def popAtStack(self, index: int) -> int:
        if 0 <= index < len(self.stacks) and self.stacks[index]:
            result = self.stacks[index].pop()
            if index not in self.available and len(self.stacks[index]) < self.capacity:
                self.available.append(index)
                self.available.sort()
            return result
        return -1