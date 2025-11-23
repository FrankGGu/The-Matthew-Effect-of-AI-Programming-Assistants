import bisect

class SnapshotArray:

    def __init__(self, length: int):
        self.snap_id = 0
        self.data = [[(0, 0)] for _ in range(length)]

    def set(self, index: int, val: int) -> None:
        if self.data[index][-1][0] == self.snap_id:
            self.data[index][-1] = (self.snap_id, val)
        else:
            self.data[index].append((self.snap_id, val))

    def snap(self) -> int:
        self.snap_id += 1
        return self.snap_id - 1

    def get(self, index: int, snap_id: int) -> int:
        history = self.data[index]
        idx = bisect.bisect_right(history, (snap_id, float('inf')))
        return history[idx-1][1]