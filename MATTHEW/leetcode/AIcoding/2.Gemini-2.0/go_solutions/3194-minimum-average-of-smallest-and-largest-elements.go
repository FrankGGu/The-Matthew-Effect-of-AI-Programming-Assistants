import (
	"math"
	"sort"
)

func minimumAverage(nums []int, k int) float64 {
	n := len(nums)
	sort.Ints(nums)
	sum := 0
	for i := 0; i < k; i++ {
		sum += nums[i]
	}
	minAvg := float64(sum) / 2.0 / float64(k)

	for i := 1; i <= n-k; i++ {
		sum = 0
		temp := nums[i : i+k]
		sort.Ints(temp)

		for j := 0; j < k; j++ {
			sum += temp[j]
		}
		avg := float64(sum) / 2.0 / float64(k)
		minAvg = math.Min(minAvg, avg)
	}
	return minAvg
}