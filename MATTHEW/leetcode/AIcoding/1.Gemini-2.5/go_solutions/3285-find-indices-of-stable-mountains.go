import "math"

func stableMountains(nums []int) [][]int {
	n := len(nums)
	if n < 3 {
		return [][]int{}
	}

	prefixMin := make([]int, n)
	prefixMin[0] = nums[0]
	for i :=