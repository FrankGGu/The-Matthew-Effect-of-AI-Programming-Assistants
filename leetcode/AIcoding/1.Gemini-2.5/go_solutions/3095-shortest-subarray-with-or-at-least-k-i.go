import "math"

func shortestSubarrayWithOR(nums []int, k int) int {
	n := len(nums)
	minLen := math.MaxInt32
	left := 0
	currentOR := 0
	bitCounts := make([]int, 31) // Max value of nums[i] is