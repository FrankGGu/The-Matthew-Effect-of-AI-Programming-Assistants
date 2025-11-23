func canMakeSubarrayZero(nums []int) bool {
	n := len(nums)
	prefixSum := make([]int, n+1)
	for i := 0; i < n; i++ {
		prefixSum[i+1] = prefixSum[i] ^ nums[i]
	}

	seen := make(map[int]bool)
	for i := 0; i <= n; i++ {
		if seen[prefixSum[i]] {
			return true
		}
		seen[prefixSum[i]] = true
	}

	return false
}