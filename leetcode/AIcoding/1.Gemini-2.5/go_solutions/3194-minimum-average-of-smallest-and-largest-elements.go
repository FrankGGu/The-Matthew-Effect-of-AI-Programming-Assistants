import (
	"math"
	"sort"
)

func minimumAverage(nums []int) float64 {
	sort.Ints(nums)

	minAvg := math.MaxFloat64
	n := len(nums)

	for i := 0; i < n/2; i++ {
		currentAvg := (float64(nums[i]) + float64(nums[n-1-i])) / 2.0
		if currentAvg < minAvg {
			minAvg = currentAvg
		}
	}

	return minAvg
}