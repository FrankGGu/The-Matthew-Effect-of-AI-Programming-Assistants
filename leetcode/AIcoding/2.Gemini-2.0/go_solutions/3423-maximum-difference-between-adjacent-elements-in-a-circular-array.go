import "math"

func maxAbsDiff(nums []int) int {
	n := len(nums)
	maxDiff := 0
	for i := 0; i < n; i++ {
		diff := math.Abs(float64(nums[i] - nums[(i+1)%n]))
		if int(diff) > maxDiff {
			maxDiff = int(diff)
		}
	}
	return maxDiff
}