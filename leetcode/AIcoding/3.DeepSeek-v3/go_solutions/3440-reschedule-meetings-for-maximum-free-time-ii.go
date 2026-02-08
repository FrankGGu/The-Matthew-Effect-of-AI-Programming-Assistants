import (
	"sort"
)

func maxFreeTime(intervals [][]int) int {
	if len(intervals) == 0 {
		return 0
	}

	sort.Slice(intervals, func(i, j int) bool {
		return intervals[i][0] < intervals[j][0]
	})

	merged := [][]int{intervals[0]}
	for i := 1; i < len(intervals); i++ {
		last := merged[len(merged)-1]
		if intervals[i][0] <= last[1] {
			if intervals[i][1] > last[1] {
				last[1] = intervals[i][1]
			}
		} else {
			merged = append(merged, intervals[i])
		}
	}

	maxGap := 0
	for i := 1; i < len(merged); i++ {
		gap := merged[i][0] - merged[i-1][1]
		if gap > maxGap {
			maxGap = gap
		}
	}

	return maxGap
}