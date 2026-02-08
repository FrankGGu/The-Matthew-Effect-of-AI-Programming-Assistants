func max(a, b int) int {
	if a > b {
		return a
	}
	return b
}

func eatPizzas(slices []int, k int) int {
	n := len(slices)
	if k > n/3 {
		k = n / 3
	}

	dp := make([][]int, n+1)
	for i := range dp {
		dp[i] = make([]int, k+1)
	}

	for i := 1; i <= n; i++ {
		for j := 1; j <= k; j++ {
			if i == 1 {
				dp[i][j] = slices[0]
			} else if i == 2 {
				if j == 1 {
					dp[i][j] = max(slices[0], slices[1])
				}
			} else {
				dp[i][j] = max(dp[i-1][j], dp[i-2][j-1]+slices[i-1])
			}
		}
	}

	ans1 := dp[n][k]

	dp = make([][]int, n+1)
	for i := range dp {
		dp[i] = make([]int, k+1)
	}

	for i := 1; i <= n; i++ {
		for j := 1; j <= k; j++ {
			if i == 1 {
				dp[i][j] = 0
			} else if i == 2 {
				dp[i][j] = slices[1]
			} else {
				dp[i][j] = max(dp[i-1][j], dp[i-2][j-1]+slices[i-1])
			}
		}
	}

	ans2 := dp[n][k]

	return max(ans1, ans2)
}