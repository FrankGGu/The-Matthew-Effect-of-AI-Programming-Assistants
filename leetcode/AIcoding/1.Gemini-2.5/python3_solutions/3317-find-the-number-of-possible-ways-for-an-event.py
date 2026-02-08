import bisect
from typing import List

class Solution:
    def maxTwoEvents(self, events: List[List[int]]) -> int:
        n = len(events)
        events.sort()

        max_val_suffix = [0] * (n + 1)
        for i in range(n - 1, -1, -1):
            max_val_suffix[i] = max(max_val_suffix[i+1], events[i][2])

        max_total_value = 0

        start_times = [event[0] for event in events]

        for i in range(n):
            max_total_value = max(max_total_value, events[i][2])

            current_event_end_time = events[i][1]

            next_event_idx = bisect.bisect_right(start_times, current_event_end_time)

            if next_event_idx < n:
                max_total_value = max(max_total_value, events[i][2] + max_val_suffix[next_event_idx])

        return max_total_value