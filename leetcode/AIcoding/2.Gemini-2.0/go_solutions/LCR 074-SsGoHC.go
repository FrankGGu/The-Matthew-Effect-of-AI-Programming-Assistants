import "sort"

func merge(intervals [][]int) [][]int {
	if len(intervals) == 0 {
		return [][]int{}
	}

	sort.Slice(intervals, func(i, j int) bool {
		return intervals[i][0] < intervals[j][0]
	})

	result := [][]int{intervals[0]}

	for i := 1; i < len(intervals); i++ {
		last := result[len(result)-1]
		curr := intervals[i]

		if curr[0] <= last[1] {
			last[1] = max(last[1], curr[1])
			result[len(result)-1] = last
		} else {
			result = append(result, curr)
		}
	}

	return result
}

func max(a, b int) int {
	if a > b {
		return a
	}
	return b
}