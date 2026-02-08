func getSumAbsoluteDifferences(nums []int) []int {
	n := len(nums)
	result := make([]int, n)
	prefixSum := make([]int, n+1)

	for i := 0; i < n; i++ {
		prefixSum[i+1] = prefixSum[i] + nums[i]
	}

	for i := 0; i < n; i++ {
		result[i] = (nums[i]*i - prefixSum[i]) + (prefixSum[n] - prefixSum[i+1] - nums[i]*(n-i-1))
	}

	return result
}