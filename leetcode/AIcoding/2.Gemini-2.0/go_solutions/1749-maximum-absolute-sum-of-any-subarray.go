import "math"

func maxAbsoluteSum(nums []int) int {
	maxSoFar := 0
	minSoFar := 0
	currentMax := 0
	currentMin := 0
	for _, num := range nums {
		currentMax = max(num, currentMax+num)
		currentMin = min(num, currentMin+num)
		maxSoFar = max(maxSoFar, currentMax)
		minSoFar = min(minSoFar, currentMin)
	}
	return max(maxSoFar, int(math.Abs(float64(minSoFar))))
}

func max(a, b int) int {
	if a > b {
		return a
	}
	return b
}

func min(a, b int) int {
	if a < b {
		return a
	}
	return b
}