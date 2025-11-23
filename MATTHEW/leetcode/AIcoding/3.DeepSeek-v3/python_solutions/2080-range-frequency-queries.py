class RangeFreqQuery:

    def __init__(self, arr: List[int]):
        from collections import defaultdict
        self.d = defaultdict(list)
        for i, num in enumerate(arr):
            self.d[num].append(i)

    def query(self, left: int, right: int, value: int) -> int:
        indices = self.d.get(value, [])
        if not indices:
            return 0
        l = bisect.bisect_left(indices, left)
        r = bisect.bisect_right(indices, right)
        return r - l