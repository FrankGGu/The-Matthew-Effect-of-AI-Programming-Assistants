import "sort"

func findRightInterval(intervals [][]int) []int {
	n := len(intervals)
	starts := make([]int, n)
	indices := make([]int, n)
	for i := 0; i < n; i++ {
		starts[i] = intervals[i][0]
		indices[i] = i
	}

	sort.Slice(indices, func(i, j int) bool {
		return starts[indices[i]] < starts[indices[j]]
	})

	result := make([]int, n)
	for i := 0; i < n; i++ {
		end := intervals[i][1]
		found := false
		for j := 0; j < n; j++ {
			if starts[indices[j]] >= end {
				result[i] = indices[j]
				found = true
				break
			}
		}
		if !found {
			result[i] = -1
		}
	}

	return result
}