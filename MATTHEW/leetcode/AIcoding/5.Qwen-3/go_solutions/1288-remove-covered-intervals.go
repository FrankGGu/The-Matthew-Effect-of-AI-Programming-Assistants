package main

func removeCoveredIntervals(intervals [][]int) int {
	sort.Slice(intervals, func(i, j int) bool {
		if intervals[i][0] == intervals[j][0] {
			return intervals[i][1] > intervals[j][1]
		}
		return intervals[i][0] < intervals[j][0]
	})
	result := 0
	prevEnd := 0
	for _, interval := range intervals {
		if interval[1] > prevEnd {
			result++
			prevEnd = interval[1]
		}
	}
	return result
}