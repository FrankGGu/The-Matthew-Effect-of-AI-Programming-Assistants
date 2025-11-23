import bisect
from collections import defaultdict

class MajorityChecker:

    def __init__(self, arr: List[int]):
        self.loc = defaultdict(list)
        for i, num in enumerate(arr):
            self.loc[num].append(i)
        self.nums = sorted(self.loc.keys(), key=lambda x: -len(self.loc[x]))

    def query(self, left: int, right: int, threshold: int) -> int:
        for num in self.nums:
            if len(self.loc[num]) < threshold:
                return -1
            l = bisect.bisect_left(self.loc[num], left)
            r = bisect.bisect_right(self.loc[num], right)
            if r - l >= threshold:
                return num
        return -1