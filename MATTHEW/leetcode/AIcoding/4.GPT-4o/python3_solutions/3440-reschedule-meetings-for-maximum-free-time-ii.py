def maxFreeTime(meetings: List[List[int]]) -> List[List[int]]:
    meetings.sort(key=lambda x: x[0])
    free_times = []

    end_time = meetings[0][1]

    for start, end in meetings[1:]:
        if start > end_time:
            free_times.append([end_time, start])
        end_time = max(end_time, end)

    return free_times