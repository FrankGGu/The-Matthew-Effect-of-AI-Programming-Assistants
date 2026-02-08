func goodIndices(nums []int, k int) []int {
	n := len(nums)
	if n < 2*k+1 {
		return []int{}
	}

	nonIncreasing := make([]int, n)
	nonDecreasing := make([]int, n)

	// Calculate non-increasing lengths