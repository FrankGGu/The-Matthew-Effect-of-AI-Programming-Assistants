func mergeStones(stones []int, k int) int {
	n := len(stones)
	if (n-1)%(k-1) != 0 {
		return -1
	}

	prefixSum := make([]int, n+1)
	for i := 1; i <= n; i++ {
		prefixSum[i] = prefixSum[i-1] + stones[i-1]
	}

	dp := make([][]int, n)
	for i := range dp {
		dp[i] = make([]int, n)
	}

	for length := k; length <= n; length++ {
		for i := 0; i <= n-length; i++ {
			j := i + length - 1
			dp[i][j] = 1000000000
			for m := i; m < j; m += k - 1 {
				dp[i][j] = min(dp[i][j], dp[i][m]+dp[m+1][j])
			}
			if (j-i)%(k-1) == 0 {
				dp[i][j] += prefixSum[j+1] - prefixSum[i]
			}
		}
	}

	return dp[0][n-1]
}

func min(a, b int) int {
	if a < b {
		return a
	}
	return b
}