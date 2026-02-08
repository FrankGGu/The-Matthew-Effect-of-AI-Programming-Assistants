func getMaxFunctionValue(receivers []int, k int64) int64 {
	n := len(receivers)
	logK := 0
	temp := k
	for temp > 0 {
		logK++
		temp >>= 1
	}

	dp := make([][]int, logK+1)
	for i := range dp {
		dp[i] = make([]int, n)
	}

	for i := 0; i < n; i++ {
		dp[0][i] = receivers[i]
	}

	for i := 1; i <= logK; i++ {
		for j := 0; j < n; j++ {
			dp[i][j] = dp[i-1][dp[i-1][j]]
		}
	}

	ans := int64(0)
	for start := 0; start < n; start++ {
		curr := start
		currSum := int64(0)
		remainingK := k

		for i := logK; i >= 0; i-- {
			if (remainingK >> i) & 1 == 1 {
				currSum += int64(curr)
				curr = dp[i][curr]
				remainingK -= (1 << i)
			}
		}
		currSum += int64(curr)

		if currSum > ans {
			ans = currSum
		}
	}

	return ans
}