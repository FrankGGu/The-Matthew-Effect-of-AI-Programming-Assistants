func slowestKey(releaseTimes []int, keysPressed string) byte {
    maxDuration := 0
    slowestKey := byte(0)

    for i := 0; i < len(keysPressed); i++ {
        duration := releaseTimes[i]
        if i > 0 {
            duration -= releaseTimes[i-1]
        }
        if duration > maxDuration || (duration == maxDuration && keysPressed[i] > slowestKey) {
            maxDuration = duration
            slowestKey = keysPressed[i]
        }
    }

    return slowestKey
}