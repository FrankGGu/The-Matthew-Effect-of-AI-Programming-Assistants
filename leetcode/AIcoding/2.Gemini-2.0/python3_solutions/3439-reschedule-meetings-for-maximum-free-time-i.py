def max_free_time(meetings):
    intervals = []
    for meeting in meetings:
        intervals.extend(meeting)
    intervals.sort(key=lambda x: x[0])

    free_time = 0
    end = float('-inf')
    for interval in intervals:
        start, finish = interval
        if start > end:
            free_time += start - end
        end = max(end, finish)

    return free_time