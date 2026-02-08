import bisect

class RangeModule:

    def __init__(self):
        self.intervals = []

    def addRange(self, left: int, right: int) -> None:
        # Find the index of the first interval [s, e] such that s >= left.
        # If the interval just before this (self.intervals[i-1]) ends at or after 'left',
        # it also overlaps or touches, so we start merging from there.
        i = bisect.bisect_left(self.intervals, [left, -float('inf')])
        if i > 0 and self.intervals[i-1][1] >= left:
            i -= 1

        # Find the index of the first interval [s, e] such that s >= right.
        # All intervals up to this index (exclusive) might be merged.
        j = bisect.bisect_left(self.intervals, [right, float('inf')])

        # Initialize the new merged interval boundaries
        new_left = left
        new_right = right

        # If there are intervals in the slice self.intervals[i:j], merge them
        if i < j:
            new_left = min(left, self.intervals[i][0])
            new_right = max(right, self.intervals[j-1][1])

        # Replace the affected intervals with the new merged interval
        self.intervals[i:j] = [[new_left, new_right]]

    def queryRange(self, left: int, right: int) -> bool:
        # Find the index of the interval that could contain [left, right].
        # We look for an interval [s, e] such that s <= left and e >= right.
        # bisect_right([left, float('inf')]) finds the insertion point for an interval starting at 'left'.
        # The interval just before this insertion point (idx-1) is the candidate.
        idx = bisect.bisect_right(self.intervals, [left, float('inf')]) - 1

        # If idx is out of bounds, or the candidate interval does not fully contain [left, right], return False.
        if idx < 0:
            return False

        s, e = self.intervals[idx]
        return s <= left and e >= right

    def removeRange(self, left: int, right: int) -> None:
        # Find the index of the first interval [s, e] such that s >= left.
        # If the interval just before this (self.intervals[i-1]) ends strictly after 'left',
        # it overlaps, so we start processing from there.
        i = bisect.bisect_left(self.intervals, [left, -float('inf')])
        if i > 0 and self.intervals[i-1][1] > left:
            i -= 1

        # Find the index of the first interval [s, e] such that s >= right.
        # If the interval just before this (self.intervals[j-1]) ends strictly after 'right',
        # it also overlaps, so we include it in the affected range.
        j = bisect.bisect_left(self.intervals, [right, -float('inf')])
        if j > 0 and self.intervals[j-1][1] > right:
            j -= 1

        # 'new_parts' will store the remaining parts of the affected intervals
        new_parts = []

        # If i <= j, there are intervals in the slice self.intervals[i:j+1] that are affected.
        if i <= j:
            first_s, first_e = self.intervals[i]
            last_s, last_e = self.intervals[j]

            # If the first affected interval starts before 'left', keep its initial part.
            if first_s < left:
                new_parts.append([first_s, left])

            # If the last affected interval ends after 'right', keep its trailing part.
            if last_e > right:
                new_parts.append([right, last_e])

        # Replace the affected intervals with the new_parts (0, 1, or 2 intervals)
        self.intervals[i:j+1] = new_parts