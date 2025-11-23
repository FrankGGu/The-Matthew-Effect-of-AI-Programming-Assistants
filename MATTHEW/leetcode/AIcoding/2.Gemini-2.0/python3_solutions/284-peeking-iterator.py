class PeekingIterator:
    def __init__(self, iterator):
        self.iterator = iterator
        self.next_element = None
        if self.iterator.hasNext():
            self.next_element = self.iterator.next()

    def peek(self):
        return self.next_element

    def next(self):
        result = self.next_element
        if self.iterator.hasNext():
            self.next_element = self.iterator.next()
        else:
            self.next_element = None
        return result

    def hasNext(self):
        return self.next_element is not None