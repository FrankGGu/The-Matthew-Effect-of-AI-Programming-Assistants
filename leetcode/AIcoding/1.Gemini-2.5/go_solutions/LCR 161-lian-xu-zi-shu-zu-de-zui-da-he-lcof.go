import "math"

func maxSubArray(nums []int) int {
	maxSoFar := nums[0]
	currentMax := nums[0]

	for i := 1; i < len(nums); i++ {
		currentMax = int(math.Max(float64(nums[i]), float64(currentMax+nums[i])))
		maxSoFar = int(math.Max(float64(maxSoFar), float64(currentMax)))
	}

	return maxSoFar
}