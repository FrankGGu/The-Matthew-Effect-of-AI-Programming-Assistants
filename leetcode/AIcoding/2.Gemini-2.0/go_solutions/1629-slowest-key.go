func slowestKey(releaseTimes []int, keysPressed string) byte {
	ans := keysPressed[0]
	maxDuration := releaseTimes[0]
	for i := 1; i < len(releaseTimes); i++ {
		duration := releaseTimes[i] - releaseTimes[i-1]
		if duration > maxDuration {
			maxDuration = duration
			ans = keysPressed[i]
		} else if duration == maxDuration && keysPressed[i] > ans {
			ans = keysPressed[i]
		}
	}
	return ans
}