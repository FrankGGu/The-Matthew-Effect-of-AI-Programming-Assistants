from typing import List

class Solution:
    def solve(self, meetings: List[List[int]]) -> int:
        if not meetings:
            return 0

        meetings.sort(key=lambda x: x[0])

        merged_intervals = []

        for start, end in meetings:
            if not merged_intervals or start > merged_intervals[-1][1]:
                merged_intervals.append([start, end])
            else:
                merged_intervals[-1][1] = max(merged_intervals[-1][1], end)

        max_free_time = 0

        for i in range(1, len(merged_intervals)):
            gap = merged_intervals[i][0] - merged_intervals[i-1][1]
            max_free_time = max(max_free_time, gap)

        return max_free_time