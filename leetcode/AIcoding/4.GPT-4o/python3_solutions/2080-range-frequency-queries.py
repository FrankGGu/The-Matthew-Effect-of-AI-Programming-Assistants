class RangeFreqQuery:

    def __init__(self, arr: List[int]):
        self.freq = {}
        for idx, num in enumerate(arr):
            if num not in self.freq:
                self.freq[num] = []
            self.freq[num].append(idx)

    def query(self, left: int, right: int, value: int) -> int:
        if value not in self.freq:
            return 0
        positions = self.freq[value]
        left_index = bisect.bisect_left(positions, left)
        right_index = bisect.bisect_right(positions, right)
        return right_index - left_index