func slowestKey(releaseTimes []int) byte {
	maxDuration := releaseTimes[0]
	resultChar := 'a'

	for i := 1; i < len(releaseTimes); i++ {
		currentDuration := releaseTimes[i] - releaseTimes[i-1]
		currentChar := rune('a' + i)

		if currentDuration > maxDuration {
			maxDuration = currentDuration
			resultChar = currentChar
		} else if currentDuration == maxDuration {
			// If durations are equal, we need to choose the button with the smallest character.
			// Since we iterate through buttons ('a', 'b', 'c', ...) in increasing order,
			// if we encounter a duration equal to the current maxDuration,
			// the currentChar ('a' + i) will always be greater than or equal to
			// the resultChar that previously achieved maxDuration.
			// To ensure we get the smallest character in case of a tie, we only
			// update resultChar if currentChar is strictly smaller, which will
			// never happen in this iteration order if resultChar was set at an earlier index.
			// Therefore, if currentDuration == maxDuration, we keep the existing resultChar.
			// No action is needed here.
		}
	}

	return byte(resultChar)
}