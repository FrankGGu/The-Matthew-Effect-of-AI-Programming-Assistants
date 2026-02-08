from sortedcontainers import SortedDict

class CountIntervals:

    def __init__(self):
        self.intervals = SortedDict()  # Stores intervals as {start: end}
        self.total_count = 0           # Stores the total number of integers covered by all intervals

    def add(self, left: int, right: int) -> None:
        # Find the index of the first interval whose start key is greater than or equal to `left`.
        # This is the starting point for our search for overlapping/adjacent intervals.
        idx = self.intervals.bisect_left(left)

        # If there's an interval immediately before `idx` that could overlap or be adjacent,
        # we need to adjust `idx` to include it.
        # An interval [s, e] overlaps/is adjacent with [L, R] if s <= R+1 and e >= L-1.
        # Here, `[s, e]` is `self.intervals.peekitem(idx-1)` and `[L, R]` is `[left, right]`.
        if idx > 0:
            prev_s, prev_e = self.intervals.peekitem(idx - 1)
            if prev_e >= left - 1:
                idx -= 1
                # If we moved `idx` back, it means `prev_s` is now the earliest start we need to consider.
                # Update `left` and `right` to potentially include `prev_s` and `prev_e`
                # in the new merged interval.
                left = min(left, prev_s)
                right = max(right, prev_e)

        # Iterate through intervals starting from `idx` that overlap or are adjacent to `[left, right]`.
        keys_to_remove = []
        current_idx = idx
        while current_idx < len(self.intervals):
            s, e = self.intervals.peekitem(current_idx)

            # If the current interval starts beyond our merged `right + 1`,
            # then no further intervals will overlap or be adjacent (since intervals are sorted by start).
            if s > right + 1:
                break

            # This interval [s, e] overlaps or is adjacent with the current merged interval [left, right].
            # Update the merged interval's boundaries.
            left = min(left, s)
            right = max(right, e)

            # Mark this interval for removal and subtract its count from the total.
            self.total_count -= (e - s + 1)
            keys_to_remove.append(s)

            current_idx += 1 # Move to the next interval in the SortedDict.

        # Remove all marked intervals.
        for s in keys_to_remove:
            del self.intervals[s]

        # Add the new merged interval to the SortedDict and update the total count.
        self.intervals[left] = right
        self.total_count += (right - left + 1)

    def count(self) -> int:
        return self.total_count