class OrderedStream:
    def __init__(self, n: int):
        self.data = [None] * n
        self.ptr = 0

    def insert(self, id: int, value: str) -> List[str]:
        self.data[id - 1] = value
        result = []
        while self.ptr < len(self.data) and self.data[self.ptr] is not None:
            result.append(self.data[self.ptr])
            self.ptr += 1
        return result