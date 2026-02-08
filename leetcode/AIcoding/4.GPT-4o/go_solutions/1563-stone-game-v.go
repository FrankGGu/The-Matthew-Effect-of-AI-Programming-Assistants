func stoneGameV(stoneValue []int) int {
	n := len(stoneValue)
	dp := make([]int, n)
	prefixSum := make([]int, n+1)
	for i := 0; i < n; i++ {
		prefixSum[i+1] = prefixSum[i] + stoneValue[i]
	}

	for length := 1; length <= n; length++ {
		for start := 0; start <= n-length; start++ {
			end := start + length - 1
			for mid := start; mid < end; mid++ {
				left := prefixSum[mid+1] - prefixSum[start]
				right := prefixSum[end+1] - prefixSum[mid+1]
				if left < right {
					dp[start] = max(dp[start], left+dp[mid+1])
				} else if left > right {
					dp[start] = max(dp[start], right+dp[end+1])
				} else {
					dp[start] = max(dp[start], left+max(dp[mid+1], dp[end+1]))
				}
			}
		}
	}

	return dp[0]
}

func max(a, b int) int {
	if a > b {
		return a
	}
	return b
}