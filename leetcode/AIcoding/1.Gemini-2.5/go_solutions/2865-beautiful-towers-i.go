import "math"

func maximumSumOfHeights(maxHeights []int) int64 {
	n := len(maxHeights)
	var maxTotalSum int64 = 0

	for i := 0; i < n; i++ {
		var currentSum int64 = 0