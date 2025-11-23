func minimumIndex(nums []int) int {
	n := len(nums)
	prefixSum := make([]int, n)
	suffixSum := make([]int, n)

	prefixSum[0] = nums[0]
	for i := 1; i < n; i++ {
		prefixSum[i] = prefixSum[i-1] + nums[i]
	}

	suffixSum[n-1] = nums[n-1]
	for i := n - 2; i >= 0; i-- {
		suffixSum[i] = suffixSum[i+1] + nums[i]
	}

	for i := 0; i < n-1; i++ {
		if prefixSum[i] == suffixSum[i+1] {
			return i
		}
	}
	return -1
}