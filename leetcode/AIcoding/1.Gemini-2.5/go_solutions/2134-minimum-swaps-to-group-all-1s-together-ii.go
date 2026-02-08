import "math"

func minSwaps(nums []int) int {
	n := len(nums)
	if n <= 1 {
		return 0
	}

	totalOnes := 0
	for _, num := range nums {
		if num == 1 {
			totalOnes++
		}