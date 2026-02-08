class MyCircularDeque:

    def __init__(self, k: int):
        self.deque = []
        self.max_size = k

    def insertFront(self, value: int) -> bool:
        if len(self.deque) < self.max_size:
            self.deque.insert(0, value)
            return True
        return False

    def insertLast(self, value: int) -> bool:
        if len(self.deque) < self.max_size:
            self.deque.append(value)
            return True
        return False

    def deleteFront(self) -> bool:
        if len(self.deque) > 0:
            self.deque.pop(0)
            return True
        return False

    def deleteLast(self) -> bool:
        if len(self.deque) > 0:
            self.deque.pop()
            return True
        return False

    def getFront(self) -> int:
        if len(self.deque) > 0:
            return self.deque[0]
        return -1

    def getRear(self) -> int:
        if len(self.deque) > 0:
            return self.deque[-1]
        return -1

    def isEmpty(self) -> bool:
        return len(self.deque) == 0

    def isFull(self) -> bool:
        return len(self.deque) == self.max_size