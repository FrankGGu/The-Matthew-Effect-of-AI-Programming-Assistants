class FrontMiddleBackQueue:

    def __init__(self):
        self.queue = []

    def pushFront(self, val: int) -> None:
        self.queue.insert(0, val)

    def pushMiddle(self, val: int) -> None:
        self.queue.insert((len(self.queue) + 1) // 2, val)

    def pushBack(self, val: int) -> None:
        self.queue.append(val)

    def popFront(self) -> int:
        return self.queue.pop(0) if self.queue else -1

    def popMiddle(self) -> int:
        if not self.queue:
            return -1
        mid_index = (len(self.queue) - 1) // 2
        return self.queue.pop(mid_index)

    def popBack(self) -> int:
        return self.queue.pop() if self.queue else -1