import "sort"

func intersectionSizeTwo(intervals [][]int) int {
	sort.Slice(intervals, func(i, j int) bool {
		if intervals[i][1] == intervals[j][1] {
			return intervals[i][0] > intervals[j][0]
		}
		return intervals[i][1] < intervals[j][1]
	})

	res := 0
	a := -1
	b := -1

	for _, interval := range intervals {
		start := interval[0]
		end := interval[1]

		if start <= a {
			continue
		} else if start <= b {
			res++
			a = b
			b = end
		} else {
			res += 2
			a = end - 1
			b = end
		}
	}

	return res
}