import (
	"sort"
)

func minimizeMaximum(n int, edges [][]int, maxOperations int) int {
	sort.Slice(edges, func(i, j int) bool {
		return edges[i][2] < edges[j][2]
	})

	check := func(mid int) bool {
		ops := 0
		for _, e := range edges {
			ops += (e[2] + mid - 1) / mid - 1
		}
		return ops <= maxOperations
	}

	left, right := 1, 1000000000
	ans := right
	for left <= right {
		mid := left + (right-left)/2
		if check(mid) {
			ans = mid
			right = mid - 1
		} else {
			left = mid + 1
		}
	}
	return ans
}