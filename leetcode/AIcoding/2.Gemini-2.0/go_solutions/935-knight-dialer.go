func knightDialer(n int) int {
	mod := 1000000007
	dp := make([][]int, n+1)
	for i := range dp {
		dp[i] = make([]int, 10)
	}

	for i := 0; i < 10; i++ {
		dp[1][i] = 1
	}

	moves := [][]int{
		{4, 6},
		{6, 8},
		{7, 9},
		{4, 8},
		{0, 3, 9},
		{},
		{0, 1, 7},
		{2, 6},
		{1, 3},
		{2, 4},
	}

	for i := 2; i <= n; i++ {
		for j := 0; j < 10; j++ {
			for _, move := range moves[j] {
				dp[i][j] = (dp[i][j] + dp[i-1][move]) % mod
			}
		}
	}

	ans := 0
	for i := 0; i < 10; i++ {
		ans = (ans + dp[n][i]) % mod
	}

	return ans
}