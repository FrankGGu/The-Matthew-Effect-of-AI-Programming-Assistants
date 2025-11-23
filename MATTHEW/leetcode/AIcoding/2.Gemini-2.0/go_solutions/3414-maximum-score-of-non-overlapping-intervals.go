import (
	"sort"
)

func maxNonOverlapping(intervals [][]int) int {
	sort.Slice(intervals, func(i, j int) bool {
		return intervals[i][1] < intervals[j][1]
	})

	count := 0
	end := -1

	for _, interval := range intervals {
		if interval[0] >= end {
			count++
			end = interval[1]
		}
	}

	return count
}