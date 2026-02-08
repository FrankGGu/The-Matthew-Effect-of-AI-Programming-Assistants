import (
	"sort"
)

func removeCoveredIntervals(intervals [][]int) int {
	sort.Slice(intervals, func(i, j int) bool {
		if intervals[i][0] != intervals[j][0] {
			return intervals[i][0] < intervals[j][0]
		}
		return intervals[i][1] > intervals[j][1]
	})

	count := 0
	maxEnd := -1

	for _, interval := range intervals {
		currentEnd := interval[1]
		if currentEnd > maxEnd {
			count++
			maxEnd = currentEnd
		}
	}

	return count
}