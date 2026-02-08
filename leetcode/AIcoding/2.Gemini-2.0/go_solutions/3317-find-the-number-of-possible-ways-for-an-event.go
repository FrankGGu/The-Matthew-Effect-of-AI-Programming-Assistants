func numberOfWays(startPos int, endPos int, k int) int {
	dp := make([][]int, 2*k+1)
	for i := range dp {
		dp[i] = make([]int, k+1)
	}

	dp[startPos+k][0] = 1

	for moves := 1; moves <= k; moves++ {
		for pos := 0; pos <= 2*k; pos++ {
			if pos > 0 {
				dp[pos][moves] = (dp[pos][moves] + dp[pos-1][moves-1]) % 1000000007
			}
			if pos < 2*k {
				dp[pos][moves] = (dp[pos][moves] + dp[pos+1][moves-1]) % 1000000007
			}
		}
	}

	return dp[endPos+k][k]
}