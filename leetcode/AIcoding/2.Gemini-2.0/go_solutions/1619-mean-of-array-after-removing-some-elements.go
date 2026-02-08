import (
	"sort"
)

func trimMean(arr []int) float64 {
	n := len(arr)
	remove := n / 20
	sort.Ints(arr)
	sum := 0
	for i := remove; i < n-remove; i++ {
		sum += arr[i]
	}
	return float64(sum) / float64(n-2*remove)
}