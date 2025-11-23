import collections
import bisect

class RangeFreqQuery:

    def __init__(self, arr: list[int]):
        self.indices = collections.defaultdict(list)
        for i, num in enumerate(arr):
            self.indices[num].append(i)

    def query(self, left: int, right: int, value: int) -> int:
        if value not in self.indices:
            return 0

        value_indices = self.indices[value]

        # Find the first index >= left
        start_idx = bisect.bisect_left(value_indices, left)

        # Find the first index > right
        end_idx = bisect.bisect_right(value_indices, right)

        return end_idx - start_idx