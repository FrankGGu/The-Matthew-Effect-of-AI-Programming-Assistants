func temperatureTrend(temperatureChanges []int, forecastChanges []int) int {
	n := len(temperatureChanges)
	m := len(forecastChanges)
	if n == 0 || m == 0 {
		return 0
	}
	maxLen := 0
	currLen := 0
	for i := 0; i < n-1 && i < m-1; i++ {
		trend1 := 0
		trend2 := 0
		if temperatureChanges[i+1] > temperatureChanges[i] {
			trend1 = 1
		} else if temperatureChanges[i+1] < temperatureChanges[i] {
			trend1 = -1
		} else {
			trend1 = 0
		}

		if forecastChanges[i+1] > forecastChanges[i] {
			trend2 = 1
		} else if forecastChanges[i+1] < forecastChanges[i] {
			trend2 = -1
		} else {
			trend2 = 0
		}

		if trend1 == trend2 {
			currLen++
			if currLen > maxLen {
				maxLen = currLen
			}
		} else {
			currLen = 0
		}
	}
	return maxLen
}