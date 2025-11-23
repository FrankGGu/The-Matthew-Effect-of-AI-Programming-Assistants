class NestedIterator:
    def __init__(self, nestedList: List[NestedInteger]):
        self.stack = []
        self.flatten(nestedList)

    def flatten(self, nestedList):
        for elem in reversed(nestedList):
            self.stack.append(elem)

    def next(self) -> int:
        return self.stack.pop().getInteger()

    def hasNext(self) -> bool:
        while self.stack:
            if self.stack[-1].isInteger():
                return True
            top = self.stack.pop()
            self.flatten(top.getList())
        return False