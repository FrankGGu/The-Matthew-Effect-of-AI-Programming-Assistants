class MyCircularDeque:

    def __init__(self, k: int):
        self.deque = [None] * k
        self.head = 0
        self.tail = 0
        self.size = 0
        self.capacity = k

    def insertFront(self, value: int) -> bool:
        if self.isFull():
            return False
        if self.isEmpty():
            self.deque[self.head] = value
        else:
            self.head = (self.head - 1) % self.capacity
            self.deque[self.head] = value
        self.size += 1
        return True

    def insertLast(self, value: int) -> bool:
        if self.isFull():
            return False
        if self.isEmpty():
            self.deque[self.tail] = value
        else:
            self.tail = (self.tail + 1) % self.capacity
            self.deque[self.tail] = value
        self.size += 1
        return True

    def deleteFront(self) -> bool:
        if self.isEmpty():
            return False
        self.deque[self.head] = None
        self.head = (self.head + 1) % self.capacity
        self.size -= 1
        if self.isEmpty():
            self.head = 0
            self.tail = 0
        return True

    def deleteLast(self) -> bool:
        if self.isEmpty():
            return False
        self.deque[self.tail] = None
        self.tail = (self.tail - 1) % self.capacity
        self.size -= 1
        if self.isEmpty():
            self.head = 0
            self.tail = 0
        return True

    def getFront(self) -> int:
        if self.isEmpty():
            return -1
        return self.deque[self.head]

    def getRear(self) -> int:
        if self.isEmpty():
            return -1
        return self.deque[self.tail]

    def isEmpty(self) -> bool:
        return self.size == 0

    def isFull(self) -> bool:
        return self.size == self.capacity