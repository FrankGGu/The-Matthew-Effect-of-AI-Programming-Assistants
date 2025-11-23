func maximumGap(nums []int) int {
	n := len(nums)
	if n < 2 {
		return 0
	}

	// The problem statement does not explicitly require O(N) solution in the main description,
	//