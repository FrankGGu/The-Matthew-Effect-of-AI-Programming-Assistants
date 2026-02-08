class Iterator:
    def __init__(self, nums: List[int]):
        self.nums = nums
        self.index = 0

    def hasNext(self) -> bool:
        return self.index < len(self.nums)

    def next(self) -> int:
        value = self.nums[self.index]
        self.index += 1
        return value

class PeekingIterator:
    def __init__(self, iterator: Iterator):
        self.iterator = iterator
        self.peeked = None

    def peek(self) -> int:
        if self.peeked is None:
            self.peeked = self.iterator.next()
        return self.peeked

    def next(self) -> int:
        if self.peeked is not None:
            value = self.peeked
            self.peeked = None
            return value
        return self.iterator.next()

    def hasNext(self) -> bool:
        return self.peeked is not None or self.iterator.hasNext()