import "sort"

func countWays(ranges [][]int) int {
	sort.Slice(ranges, func(i, j int) bool {
		return ranges[i][0] < ranges[j][0]
	})

	count := 1
	end := ranges[0][1]
	for i := 1; i < len(ranges); i++ {
		if ranges[i][0] > end {
			count++
		}
		if ranges[i][1] > end {
			end = ranges[i][1]
		}
	}

	res := 1
	mod := 1000000007
	for i := 0; i < count; i++ {
		res = (res * 2) % mod
	}

	return res
}