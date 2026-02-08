func getAverages(nums []int, k int) []int {
	n := len(nums)
	averages := make([]int, n)
	for i := range averages {
		averages[i] = -1
	}

	if 2*k+1 > n {
		return averages
	}

	prefixSum := make([]int, n+1)
	for i := 0; i < n; i++ {
		prefixSum[i+1] = prefixSum[i] + nums[i]
	}

	for i := k; i < n-k; i++ {
		sum := prefixSum[i+k+1] - prefixSum[i-k]
		averages[i] = sum / (2*k + 1)
	}

	return averages
}