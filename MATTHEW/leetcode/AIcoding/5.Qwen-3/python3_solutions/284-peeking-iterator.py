class PeekingIterator:
    def __init__(self, iterator):
        self.iterator = iterator
        self.peeked = None

    def hasNext(self):
        return self.peeked is not None or self.iterator.hasNext()

    def next(self):
        if self.peeked is None:
            return self.iterator.next()
        else:
            val = self.peeked
            self.peeked = None
            return val

    def peek(self):
        if self.peeked is None:
            self.peeked = self.iterator.next()
        return self.peeked