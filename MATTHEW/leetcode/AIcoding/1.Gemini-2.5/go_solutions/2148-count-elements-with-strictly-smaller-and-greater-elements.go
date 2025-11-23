import "math"

func countElements(nums []int) int {
	minVal := math.MaxInt32
	maxVal := math.MinInt32

	for _, num := range nums {
		if num < minVal {
			minVal = num
		}
		if num > maxVal {
			maxVal = num
		}
	}

	if minVal == maxVal {
		return 0
	}

	count := 0
	for _, num := range nums {
		if num > minVal && num < maxVal {
			count++
		}
	}

	return count
}