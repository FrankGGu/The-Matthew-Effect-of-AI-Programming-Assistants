import (
	"sort"
)

func getStrongest(arr []int, k int) []int {
	sort.Ints(arr)
	n := len(arr)
	median := arr[(n-1)/2]
	sort.Slice(arr, func(i, j int) bool {
		absI := abs(arr[i] - median)
		absJ := abs(arr[j] - median)
		if absI != absJ {
			return absI > absJ
		}
		return arr[i] > arr[j]
	})
	return arr[:k]
}

func abs(x int) int {
	if x < 0 {
		return -x
	}
	return x
}