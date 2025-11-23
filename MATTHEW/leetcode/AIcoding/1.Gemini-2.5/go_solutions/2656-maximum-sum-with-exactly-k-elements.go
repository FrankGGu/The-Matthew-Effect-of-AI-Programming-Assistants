func maximizeSum(nums []int, k int) int {
	// Find the maximum element in the nums array.
	maxNum := 0
	for _, num := range nums {
		if num > maxNum {
			maxNum = num
		}
	}

	// Calculate the score by performing the operation k