import "sort"

func merge(intervals [][]int) [][]int {
	if len(intervals) == 0 {
		return [][]int{}
	}

	sort.Slice(intervals, func(i, j int) bool {
		return intervals[i][0] < intervals[j][0]
	})

	merged := [][]int{}
	for _, interval := range intervals {
		if len(merged) == 0 || interval[0] > merged[len(merged)-1][1] {
			merged = append(merged, interval)
		} else {
			merged[len(merged)-1][1] = max(merged[len(merged)-1][1], interval[1])
		}
	}

	return merged
}

func max(a, b int) int {
	if a > b {
		return a
	}
	return b
}