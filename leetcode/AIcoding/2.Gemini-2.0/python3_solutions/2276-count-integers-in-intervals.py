class CountIntervals:

    def __init__(self):
        self.intervals = []
        self.count = 0

    def add(self, left: int, right: int) -> None:
        new_intervals = []
        insert = False
        for l, r in self.intervals:
            if right < l:
                new_intervals.append((l, r))
            elif left > r:
                new_intervals.append((l, r))
            else:
                left = min(left, l)
                right = max(right, r)
                self.count -= (r - l + 1)

        new_intervals.append((left, right))
        new_intervals.sort()

        self.intervals = []

        merged_intervals = []

        for l, r in new_intervals:
            if not merged_intervals:
                merged_intervals.append([l,r])
            else:
                last_l, last_r = merged_intervals[-1]
                if l <= last_r:
                    merged_intervals[-1][1] = max(last_r, r)
                else:
                    merged_intervals.append([l,r])

        for l,r in merged_intervals:
            self.intervals.append((l,r))
            self.count += (r - l + 1)

    def count(self) -> int:
        return self.count