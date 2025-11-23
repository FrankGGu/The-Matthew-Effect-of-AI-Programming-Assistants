class SnapshotArray:

    def __init__(self, length: int):
        self.snapshots = {}
        self.current = [0] * length
        self.snap_id = 0

    def set(self, index: int, val: int) -> None:
        self.current[index] = val

    def snap(self) -> int:
        self.snapshots[self.snap_id] = self.current[:]
        self.snap_id += 1
        return self.snap_id - 1

    def get(self, index: int, snap_id: int) -> int:
        if snap_id in self.snapshots:
            return self.snapshots[snap_id][index]
        return 0