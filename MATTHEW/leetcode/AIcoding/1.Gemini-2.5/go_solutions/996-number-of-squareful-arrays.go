func numSquarefulPerms(nums []int) int {
	n := len(nums)
	if n == 0 {
		return 0
	}

	// Step 1: Count frequencies of numbers
	counts := make(map[int]int)