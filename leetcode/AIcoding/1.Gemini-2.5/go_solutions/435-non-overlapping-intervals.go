func eraseOverlapIntervals(intervals [][]int) int {
	if len(intervals) == 0 {
		return 0
	}

	// Sort intervals by their end times.
	// If end times are equal, sorting by start times doesn't change the outcome significantly
	// for the greedy