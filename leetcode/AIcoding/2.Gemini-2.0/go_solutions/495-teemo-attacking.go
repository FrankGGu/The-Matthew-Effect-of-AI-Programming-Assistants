func findPoisonedDuration(timeSeries []int, duration int) int {
	if len(timeSeries) == 0 {
		return 0
	}

	totalDuration := 0
	for i := 0; i < len(timeSeries)-1; i++ {
		diff := timeSeries[i+1] - timeSeries[i]
		if diff < duration {
			totalDuration += diff
		} else {
			totalDuration += duration
		}
	}
	totalDuration += duration

	return totalDuration
}