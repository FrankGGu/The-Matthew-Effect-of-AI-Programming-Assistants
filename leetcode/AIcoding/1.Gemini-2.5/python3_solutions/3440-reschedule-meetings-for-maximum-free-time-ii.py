from typing import List

class Solution:
    def maxFreeTime(self, meetings: List[List[int]]) -> int:
        if not meetings:
            return 0

        meetings.sort()

        merged_intervals = []
        for meeting in meetings:
            if not merged_intervals or meeting[0] > merged_intervals[-1][1]:
                merged_intervals.append(meeting)
            else:
                merged_intervals[-1][1] = max(merged_intervals[-1][1], meeting[1])

        max_gap = 0
        for i in range(1, len(merged_intervals)):
            gap = merged_intervals[i][0] - merged_intervals[i-1][1]
            max_gap = max(max_gap, gap)

        return max_gap