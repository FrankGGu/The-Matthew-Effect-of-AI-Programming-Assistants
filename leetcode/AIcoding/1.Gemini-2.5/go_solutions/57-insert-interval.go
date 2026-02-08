func min(a, b int) int {
	if a < b {
		return a
	}
	return b
}

func max(a, b int) int {
	if a > b {
		return a
	}
	return b
}

func insert(intervals [][]int, newInterval []int) [][]int {
	var result [][]int

	i := 0
	n := len(intervals)

	// Phase 1: Add all intervals that come before newInterval and don't overlap
	for i < n && intervals[i][1] < newInterval[0] {
		result = append(result, intervals[i])
		i++
	}

	// Phase 2: Merge newInterval with all overlapping intervals
	// An overlap exists if interval[0] <= newInterval[1]
	// (because intervals[i][1] < newInterval[0] is already handled by the first loop)
	for i < n && intervals[i][0] <= newInterval[1] {
		newInterval[0] = min(newInterval[0], intervals[i][0])
		newInterval[1] = max(newInterval[1], intervals[i][1])
		i++
	}
	result = append(result, newInterval) // Add the merged newInterval

	// Phase 3: Add all intervals that come after newInterval and don't overlap
	for i < n {
		result = append(result, intervals[i])
		i++
	}

	return result
}