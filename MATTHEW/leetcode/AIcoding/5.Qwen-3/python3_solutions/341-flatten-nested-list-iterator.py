class NestedInteger:
    def isInteger(self) -> bool:
        pass

    def getInteger(self) -> int:
        pass

    def getList(self):
        pass

class NestedIterator:
    def __init__(self, nestedList):
        self.stack = []
        self.current = nestedList

    def next(self) -> int:
        return self.current.getInteger()

    def hasNext(self) -> bool:
        while self.stack or self.current:
            if not self.current:
                self.current = self.stack.pop()
                continue
            if self.current.isInteger():
                return True
            self.stack.append(self.current)
            self.current = self.current.getList()[0]
        return False