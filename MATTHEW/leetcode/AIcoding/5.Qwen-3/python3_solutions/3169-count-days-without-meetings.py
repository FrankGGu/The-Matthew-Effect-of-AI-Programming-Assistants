class Solution:
    def countDays(self, days: int, meetings: List[List[int]]) -> int:
        if not meetings:
            return days
        meetings.sort()
        prev_end = meetings[0][1]
        count = 0
        for start, end in meetings[1:]:
            if start > prev_end:
                count += start - prev_end
            prev_end = max(prev_end, end)
        if prev_end < days:
            count += days - prev_end
        return count