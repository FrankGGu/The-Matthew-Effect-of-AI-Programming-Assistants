func getAverages(nums []int, k int) []int {
	n := len(nums)
	ans := make([]int, n)

	for i := 0; i < n; i++ {
		ans[i] = -1
	}

	windowSize := 2*k + 1
	if windowSize > n {
		return ans
	}

	var currentSum int64
	for i := 0; i < windowSize; i++ {
		currentSum += int64(nums[i])
	}

	ans[k] = int(currentSum / int64(windowSize))

	for i := k + 1; i < n-k; i++ {
		currentSum = currentSum - int64(nums[i-k-1]) + int64(nums[i+k])
		ans[i] = int(currentSum / int64(windowSize))
	}

	return ans
}