func maximizeSum(nums []int, k int) int {
	maxVal := 0
	for _, num := range nums {
		if num > maxVal {
			maxVal = num
		}
	}

	// The sum of an arithmetic progression: k * (first_term + last_term) /