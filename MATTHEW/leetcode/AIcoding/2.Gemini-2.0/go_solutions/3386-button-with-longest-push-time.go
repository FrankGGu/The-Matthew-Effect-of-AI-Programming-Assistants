func longestButtonPress(releaseTimes []int, pressedKeys string) byte {
	maxTime := releaseTimes[0]
	ans := pressedKeys[0]
	for i := 1; i < len(releaseTimes); i++ {
		duration := releaseTimes[i] - releaseTimes[i-1]
		if duration > maxTime {
			maxTime = duration
			ans = pressedKeys[i]
		} else if duration == maxTime && pressedKeys[i] > ans {
			ans = pressedKeys[i]
		}
	}
	return ans
}