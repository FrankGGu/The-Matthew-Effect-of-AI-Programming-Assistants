package solution

import "math"

func minMoves(nums []int) int {
	if len(nums) == 0 {
		return 0
	}

	minVal := math.MaxInt64
	sum := 0

	for _, num := range nums {
		if num < minVal {
			minVal = num
		}
		sum += num
	}

	return sum - len(nums)*minVal
}