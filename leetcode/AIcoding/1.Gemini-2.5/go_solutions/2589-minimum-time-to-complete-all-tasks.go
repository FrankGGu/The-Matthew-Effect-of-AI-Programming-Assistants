func minTime(tasks [][]int) int {
	// Sort tasks by their end times. If end times are equal, sort by start times.
	sort.Slice(tasks, func(i, j int) bool {
		if tasks[i][1] != tasks[j][1] {