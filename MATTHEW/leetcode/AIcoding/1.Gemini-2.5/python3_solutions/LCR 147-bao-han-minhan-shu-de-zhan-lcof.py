class MinStack:

    def __init__(self):
        self.stack = []
        self.min_stack = []

    def push(self, val: int) -> None:
        self.stack.append(val)
        if not self.min_stack or val <= self.min_stack[-1]:
            self.min_stack.append(val)

    def pop(self) -> None:
        if self.stack:
            popped_val = self.stack.pop()
            if popped_val == self.min_stack[-1]:
                self.min_stack.pop()

    def top(self) -> int:
        if self.stack:
            return self.stack[-1]
        return None # Or raise an error, but LeetCode typically assumes valid calls

    def getMin(self) -> int:
        if self.min_stack:
            return self.min_stack[-1]
        return None # Or raise an error, but LeetCode typically assumes valid calls