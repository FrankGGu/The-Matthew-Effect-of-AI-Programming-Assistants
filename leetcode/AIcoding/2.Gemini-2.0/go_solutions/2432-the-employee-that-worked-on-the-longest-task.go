func hardestWorker(n int, logs [][]int) int {
	maxTime := logs[0][1]
	employee := logs[0][0]

	for i := 1; i < len(logs); i++ {
		duration := logs[i][1] - logs[i-1][1]
		if duration > maxTime {
			maxTime = duration
			employee = logs[i][0]
		} else if duration == maxTime && logs[i][0] < employee {
			employee = logs[i][0]
		}
	}

	return employee
}