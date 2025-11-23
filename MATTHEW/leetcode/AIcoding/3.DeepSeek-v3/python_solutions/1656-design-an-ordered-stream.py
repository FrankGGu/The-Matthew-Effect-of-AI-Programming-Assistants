class OrderedStream:

    def __init__(self, n: int):
        self.stream = [None] * (n + 2)
        self.ptr = 1

    def insert(self, idKey: int, value: str) -> List[str]:
        self.stream[idKey] = value
        res = []
        if idKey == self.ptr:
            while self.stream[self.ptr] is not None:
                res.append(self.stream[self.ptr])
                self.ptr += 1
        return res