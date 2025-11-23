class MyCircularQueue:

    def __init__(self, k: int):
        self.size = k + 1
        self.queue = [0] * self.size
        self.head = self.tail = 0

    def enQueue(self, value: int) -> bool:
        if (self.tail + 1) % self.size == self.head:
            return False
        self.queue[self.tail] = value
        self.tail = (self.tail + 1) % self.size
        return True

    def deQueue(self) -> bool:
        if self.head == self.tail:
            return False
        self.head = (self.head + 1) % self.size
        return True

    def Front(self) -> int:
        if self.head == self.tail:
            return -1
        return self.queue[self.head]

    def Rear(self) -> int:
        if self.head == self.tail:
            return -1
        return self.queue[(self.tail - 1 + self.size) % self.size]

    def isEmpty(self) -> bool:
        return self.head == self.tail

    def isFull(self) -> bool:
        return (self.tail + 1) % self.size == self.head