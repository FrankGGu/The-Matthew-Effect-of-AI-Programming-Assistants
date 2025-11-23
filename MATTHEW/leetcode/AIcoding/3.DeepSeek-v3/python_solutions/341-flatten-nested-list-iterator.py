class NestedIterator:
    def __init__(self, nestedList: [NestedInteger]):
        self.stack = []
        self.flatten(nestedList)

    def flatten(self, nestedList):
        for i in range(len(nestedList)-1, -1, -1):
            self.stack.append(nestedList[i])

    def next(self) -> int:
        return self.stack.pop().getInteger()

    def hasNext(self) -> bool:
        while self.stack:
            top = self.stack[-1]
            if top.isInteger():
                return True
            self.stack.pop()
            self.flatten(top.getList())
        return False