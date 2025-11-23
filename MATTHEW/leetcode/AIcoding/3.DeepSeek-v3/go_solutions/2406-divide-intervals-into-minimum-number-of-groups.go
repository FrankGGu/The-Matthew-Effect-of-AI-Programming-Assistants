import (
	"sort"
)

func minGroups(intervals [][]int) int {
	starts := make([]int, len(intervals))
	ends := make([]int, len(intervals))
	for i, interval := range intervals {
		starts[i] = interval[0]
		ends[i] = interval[1]
	}
	sort.Ints(starts)
	sort.Ints(ends)

	res, count := 0, 0
	i, j := 0, 0
	for i < len(starts) && j < len(ends) {
		if starts[i] <= ends[j] {
			count++
			i++
			if count > res {
				res = count
			}
		} else {
			count--
			j++
		}
	}
	return res
}