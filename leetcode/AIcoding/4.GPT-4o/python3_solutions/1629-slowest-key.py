def slowestKey(releaseTimes: List[int], keysPressed: str) -> str:
    max_time = 0
    slowest_key = ''

    for i in range(len(releaseTimes)):
        if i == 0:
            duration = releaseTimes[i]
        else:
            duration = releaseTimes[i] - releaseTimes[i - 1]

        if duration > max_time or (duration == max_time and keysPressed[i] > slowest_key):
            max_time = duration
            slowest_key = keysPressed[i]

    return slowest_key