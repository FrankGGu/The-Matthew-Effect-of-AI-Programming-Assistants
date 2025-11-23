def findPoisonedDuration(timeSeries, duration):
    if not timeSeries:
        return 0
    total_time = 0
    for i in range(1, len(timeSeries)):
        total_time += min(timeSeries[i] - timeSeries[i - 1], duration)
    total_time += duration
    return total_time