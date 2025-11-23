class NestedIterator:
    def __init__(self, nestedList: [NestedInteger]):
        self.stack = []
        # Initialize the stack by pushing elements from nestedList in reverse order.
        # This ensures that the first element of nestedList is at the top of the stack
        # and will be processed first.
        for i in range(len(nestedList) - 1, -1, -1):
            self.stack.append(nestedList[i])

    def next(self) -> int:
        # According to the problem description, next() is only called if hasNext() is true.
        # This guarantees that the top of the stack is an integer NestedInteger.
        return self.stack.pop().getInteger()

    def hasNext(self) -> bool:
        # Keep processing the stack until an integer is found or the stack becomes empty.
        while self.stack:
            top_element = self.stack[-1]  # Peek at the top element

            if top_element.isInteger():
                # If the top element is an integer, we've found the next element.
                return True
            else:
                # If the top element is a list, pop it and push its contents onto the stack
                # in reverse order. This flattens the list one level at a time.
                self.stack.pop()  # Remove the list NestedInteger
                sub_list = top_element.getList()
                for i in range(len(sub_list) - 1, -1, -1):
                    self.stack.append(sub_list[i])

        # If the loop finishes, the stack is empty and no more integers are found.
        return False