import "math"

func maximumDifference(nums []int) int {
	maxDiff := -1
	minVal := nums[0]

	for i := 1; i < len(nums); i++ {
		if nums[i] > minVal {
			diff := nums[i] - minVal
			maxDiff = int(math.Max(float64(maxDiff), float64(diff)))
		} else {
			minVal = nums[i]
		}
	}

	return maxDiff
}