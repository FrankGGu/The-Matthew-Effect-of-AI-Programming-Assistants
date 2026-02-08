func leftRightDifference(nums []int) []int {
	n := len(nums)
	leftSum := make([]int, n)
	rightSum := make([]int, n)
	result := make([]int, n)

	for i := 1; i < n; i++ {
		leftSum[i] = leftSum[i-1] + nums[i-1]
	}

	for i := n - 2; i >= 0; i-- {
		rightSum[i] = rightSum[i+1] + nums[i+1]
	}

	for i := 0; i < n; i++ {
		diff := leftSum[i] - rightSum[i]
		if diff < 0 {
			diff = -diff
		}
		result[i] = diff
	}

	return result
}