import (
	"sort"
)

func findRightInterval(intervals [][]int) []int {
	n := len(intervals)
	if n == 0 {
		return []int{}
	}

	startPoints := make([]int, n)
	startToIndex := make(map[int]int, n)

	for i := 0; i < n; i++ {
		startPoints[i] = intervals[i][0]
		startToIndex[intervals[i][0]] = i
	}

	sort.Ints(startPoints)

	result := make([]int, n)
	for i := 0; i < n; i++ {
		endValue := intervals[i][1]

		j := sort.SearchInts(startPoints, endValue)

		if j < n {
			result[i] = startToIndex[startPoints[j]]
		} else {
			result[i] = -1
		}
	}

	return result
}