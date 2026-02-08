class PeekingIterator:
    def __init__(self, iterator):
        self._iterator = iterator
        self._next_element = None
        self._has_next_element = False
        self._advance_iterator()

    def _advance_iterator(self):
        if self._iterator.hasNext():
            self._next_element = self._iterator.next()
            self._has_next_element = True
        else:
            self._next_element = None
            self._has_next_element = False

    def peek(self):
        return self._next_element

    def next(self):
        current_element = self._next_element
        self._advance_iterator()
        return current_element

    def hasNext(self):
        return self._has_next_element