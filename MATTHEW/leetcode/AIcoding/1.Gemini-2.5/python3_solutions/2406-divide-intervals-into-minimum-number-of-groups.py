import collections

class Solution:
    def minGroups(self, intervals: list[list[int]]) -> int:
        events = []
        for start, end in intervals:
            events.append((start, 1))  # 1 for start event
            events.append((end, -1))   # -1 for end event

        # Sort events: first by time, then by type.
        # If times are equal, process end events (-1) before start events (1)
        # to correctly handle intervals that touch but don't overlap, e.g., [1,2] and [2,3].
        events.sort()

        current_overlap = 0
        max_overlap = 0

        for time, type_val in events:
            current_overlap += type_val
            max_overlap = max(max_overlap, current_overlap)

        return max_overlap