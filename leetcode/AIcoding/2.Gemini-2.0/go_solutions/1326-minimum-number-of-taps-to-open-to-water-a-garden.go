import (
	"sort"
)

func minTaps(n int, ranges []int) int {
	intervals := make([][]int, n+1)
	for i := 0; i <= n; i++ {
		intervals[i] = []int{i - ranges[i], i + ranges[i]}
	}

	sort.Slice(intervals, func(i, j int) bool {
		return intervals[i][0] < intervals[j][0]
	})

	taps := 0
	covered := 0
	i := 0

	for covered < n {
		maxReach := covered
		for i < len(intervals) && intervals[i][0] <= covered {
			maxReach = max(maxReach, intervals[i][1])
			i++
		}

		if maxReach == covered {
			return -1
		}

		taps++
		covered = maxReach
	}

	return taps
}

func max(a, b int) int {
	if a > b {
		return a
	}
	return b
}