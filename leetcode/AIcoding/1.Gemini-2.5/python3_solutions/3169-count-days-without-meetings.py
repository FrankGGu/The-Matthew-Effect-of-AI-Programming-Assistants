class Solution:
    def countDays(self, days: int, meetings: list[list[int]]) -> int:
        if not meetings:
            return days

        meetings.sort()

        merged_meetings = []
        for start, end in meetings:
            if not merged_meetings or start > merged_meetings[-1][1] + 1:
                merged_meetings.append([start, end])
            else:
                merged_meetings[-1][1] = max(merged_meetings[-1][1], end)

        total_meeting_days = 0
        for start, end in merged_meetings:
            total_meeting_days += (end - start + 1)

        return days - total_meeting_days