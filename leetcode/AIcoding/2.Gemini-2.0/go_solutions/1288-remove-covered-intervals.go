import "sort"

func removeCoveredIntervals(intervals [][]int) int {
	sort.Slice(intervals, func(i, j int) bool {
		if intervals[i][0] == intervals[j][0] {
			return intervals[i][1] > intervals[j][1]
		}
		return intervals[i][0] < intervals[j][0]
	})

	count := 0
	end := -1

	for _, interval := range intervals {
		if interval[1] > end {
			count++
			end = interval[1]
		}
	}

	return count
}