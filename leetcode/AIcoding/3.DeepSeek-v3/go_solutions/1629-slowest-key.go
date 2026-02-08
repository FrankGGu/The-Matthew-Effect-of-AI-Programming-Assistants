func slowestKey(releaseTimes []int, keysPressed string) byte {
    maxDuration := releaseTimes[0]
    result := keysPressed[0]

    for i := 1; i < len(releaseTimes); i++ {
        duration := releaseTimes[i] - releaseTimes[i-1]
        if duration > maxDuration || (duration == maxDuration && keysPressed[i] > result) {
            maxDuration = duration
            result = keysPressed[i]
        }
    }

    return result
}