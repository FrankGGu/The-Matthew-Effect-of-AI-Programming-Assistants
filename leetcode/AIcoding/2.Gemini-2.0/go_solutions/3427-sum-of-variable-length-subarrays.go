func sumOfVariableLengthSubarrays(nums []int, queries [][]int) []int {
	n := len(nums)
	prefixSum := make([]int, n+1)
	for i := 0; i < n; i++ {
		prefixSum[i+1] = prefixSum[i] + nums[i]
	}

	ans := make([]int, len(queries))
	for i, query := range queries {
		l, r := query[0], query[1]
		ans[i] = prefixSum[r+1] - prefixSum[l]
	}

	return ans
}