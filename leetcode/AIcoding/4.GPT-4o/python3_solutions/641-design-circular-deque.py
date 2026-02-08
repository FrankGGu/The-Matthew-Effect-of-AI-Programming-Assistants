class MyCircularDeque:

    def __init__(self, k: int):
        self.k = k
        self.deque = [0] * k
        self.head = 0
        self.tail = 0
        self.size = 0

    def insertFront(self, value: int) -> bool:
        if self.size == self.k:
            return False
        self.head = (self.head - 1) % self.k
        self.deque[self.head] = value
        self.size += 1
        return True

    def insertLast(self, value: int) -> bool:
        if self.size == self.k:
            return False
        self.deque[self.tail] = value
        self.tail = (self.tail + 1) % self.k
        self.size += 1
        return True

    def deleteFront(self) -> bool:
        if self.size == 0:
            return False
        self.head = (self.head + 1) % self.k
        self.size -= 1
        return True

    def deleteLast(self) -> bool:
        if self.size == 0:
            return False
        self.tail = (self.tail - 1) % self.k
        self.size -= 1
        return True

    def getFront(self) -> int:
        if self.size == 0:
            return -1
        return self.deque[self.head]

    def getRear(self) -> int:
        if self.size == 0:
            return -1
        return self.deque[(self.tail - 1) % self.k]

    def isEmpty(self) -> bool:
        return self.size == 0

    def isFull(self) -> bool:
        return self.size == self.k