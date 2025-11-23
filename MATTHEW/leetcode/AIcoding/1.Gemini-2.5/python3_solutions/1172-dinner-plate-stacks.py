import heapq

class DinnerPlates:

    def __init__(self, capacity: int):
        self.capacity = capacity
        self.stacks = []  # List of lists, each representing a stack
        self.available_stacks = []  # Min-heap of indices of stacks that have space

    def push(self, val: int) -> None:
        # Clean up stale entries in available_stacks
        # An entry is stale if the stack it points to is now full
        # or if the stack no longer exists (due to pop trimming self.stacks)
        while self.available_stacks and \
              (self.available_stacks[0] >= len(self.stacks) or \
               len(self.stacks[self.available_stacks[0]]) == self.capacity):
            heapq.heappop(self.available_stacks)

        # If no available stack, create a new one
        if not self.available_stacks:
            self.stacks.append([])
            heapq.heappush(self.available_stacks, len(self.stacks) - 1)

        # Get the leftmost available stack index
        stack_idx = heapq.heappop(self.available_stacks)

        # Push the value
        self.stacks[stack_idx].append(val)

        # If the stack still has space, add its index back to available_stacks
        if len(self.stacks[stack_idx]) < self.capacity:
            heapq.heappush(self.available_stacks, stack_idx)

    def pop(self) -> int:
        # Remove empty stacks from the end
        while self.stacks and not self.stacks[-1]:
            self.stacks.pop()

        # If no stacks exist, return -1
        if not self.stacks:
            return -1

        # Pop from the rightmost non-empty stack
        stack_idx = len(self.stacks) - 1
        val = self.stacks[stack_idx].pop()

        # This stack now has space, so add its index to available_stacks
        heapq.heappush(self.available_stacks, stack_idx)

        return val

    def popAtStack(self, index: int) -> int:
        # Check if the index is valid and the stack is not empty
        if index >= len(self.stacks) or not self.stacks[index]:
            return -1

        # Pop the value
        val = self.stacks[index].pop()

        # This stack now has space, so add its index to available_stacks
        heapq.heappush(self.available_stacks, index)

        return val