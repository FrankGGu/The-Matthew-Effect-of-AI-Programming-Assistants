func maxValue(events [][]int, k int) int {
	// Sort events by start time. If start times are equal, sort by end time.
	sort.Slice(events, func(i, j int) bool {
		if events[i][0] != events[j][0]