func waysToSplitArray(nums []int) int {
	n := len(nums)
	prefixSum := make([]int, n)
	prefixSum[0] = nums[0]
	for i := 1; i < n; i++ {
		prefixSum[i] = prefixSum[i-1] + nums[i]
	}

	count := 0
	for i := 0; i < n-1; i++ {
		leftSum := prefixSum[i]
		rightSum := prefixSum[n-1] - prefixSum[i]
		if leftSum >= rightSum {
			count++
		}
	}

	return count
}