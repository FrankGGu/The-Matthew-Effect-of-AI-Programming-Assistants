func slowestKey(releaseTimes []int, keysPressed string) byte {
	maxDuration := 0
	var slowestKey byte // Initialized to zero value, which is 0 for byte (NUL character)
	prevReleaseTime := 0

	for i := 0; i < len(releaseTimes); i++ {
		currentDuration := releaseTimes[i] - prevReleaseTime
		currentKey := keysPressed[i] // keysPressed[i] returns a byte

		if currentDuration > maxDuration {
			maxDuration = currentDuration
			slowestKey = currentKey
		} else if currentDuration == maxDuration {
			// If durations are equal, choose the lexicographically largest key
			if currentKey > slowestKey {
				slowestKey = currentKey
			}
		}

		prevReleaseTime = releaseTimes[i]
	}

	return slowestKey
}