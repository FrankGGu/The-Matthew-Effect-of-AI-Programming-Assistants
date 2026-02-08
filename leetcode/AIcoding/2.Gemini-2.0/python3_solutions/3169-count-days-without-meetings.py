def countDaysWithoutMeetings(meetings: list[list[int]], workHours: int) -> int:
    meetings.sort()
    total_meetings_hours = 0
    for start, end in meetings:
        total_meetings_hours += (end - start)

    if total_meetings_hours >= len(meetings) * workHours:
        return 0

    return len(meetings) - (total_meetings_hours // workHours)