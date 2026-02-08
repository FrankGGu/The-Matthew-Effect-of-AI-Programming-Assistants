func max(a, b int) int {
	if a > b {
		return a
	}
	return b
}

func maxTwoEvents(events [][]int) int {
	// Sort events by their start times.
	sort.Slice(events, func(i,