func temperatureTrend(temperatureA []int, temperatureB []int) int {
	n := len(temperatureA)
	if n <= 1 {
		return 0
	}

	maxTrend := 0
	currentTrend := 0

	for i := 1; i < n; i++ {
		trend