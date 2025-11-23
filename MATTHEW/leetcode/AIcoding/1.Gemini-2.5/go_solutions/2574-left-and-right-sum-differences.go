import "math"

func leftRightDifference(nums []int) []int {
	n := len(nums)
	if n == 0 {
		return []int{}
	}

	answer := make([]int, n)

	totalSum := 0
	for _, num := range nums {
		totalSum