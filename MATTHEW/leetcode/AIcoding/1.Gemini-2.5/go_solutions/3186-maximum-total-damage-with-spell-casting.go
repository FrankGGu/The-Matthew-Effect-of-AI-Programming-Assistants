func max(a, b int) int {
	if a > b {
		return a
	}
	return b
}

func maxTotalDamage(damage []int) int {
	if len(damage) == 0 {
		return 0
	}

	maxDmgVal := 0
	for _, d := range damage {
		if d > maxDmgVal {
			maxDmgVal = d
		}
	}

	freq := make([]int, maxDmgVal+1)
	for _, d := range damage {
		freq[d]++
	}

	dp := make([]int, maxDmgVal+1)

	// dp[0] is 0 by default.
	// Since damage[i] >= 1, maxDmgVal will always be at least 1 if damage is not empty.
	// So, dp[1] will always be accessed.
	dp[1] = freq[1] * 1

	for i := 2; i <= maxDmgVal; i++ {
		dp[i] = max(dp[i-1], dp[i-2]+freq[i]*i)
	}

	return dp[maxDmgVal]
}