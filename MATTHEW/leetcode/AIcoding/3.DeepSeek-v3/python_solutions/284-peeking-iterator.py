class PeekingIterator:
    def __init__(self, iterator):
        """
        Initialize your data structure here.
        :type iterator: Iterator
        """
        self.iterator = iterator
        self.peeked = None

    def peek(self):
        """
        Returns the next element in the iteration without advancing the iterator.
        :rtype: int
        """
        if self.peeked is None:
            self.peeked = self.iterator.next()
        return self.peeked

    def next(self):
        """
        :rtype: int
        """
        if self.peeked is not None:
            val = self.peeked
            self.peeked = None
            return val
        return self.iterator.next()

    def hasNext(self):
        """
        :rtype: bool
        """
        return self.peeked is not None or self.iterator.hasNext()