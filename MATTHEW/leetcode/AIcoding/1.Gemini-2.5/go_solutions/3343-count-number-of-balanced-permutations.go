func countBalancedPermutations(n int) int {
	const MOD = 1e9 + 7

	if n%2 == 0 {
		return 0
	}

	if n == 1 {
		return 1
	}

	targetAscents := (n - 1) / 2

	dp := make([][]int, n+1)
	for i := range dp {
		dp[i] = make([]int, i)
	}

	dp[1][0] = 1

	for i := 2; i <= n; i++ {
		for j := 0; j < i; j++ {
			if j < i-1 {
				dp[i][j] = (dp[i][j] + (j+1)*dp[i-1][j]) % MOD
			}

			if j-1 >= 0 {
				dp[i][j] = (dp[i][j] + (i-j)*dp[i-1][j-1]) % MOD
			}
		}
	}

	return dp[n][targetAscents]
}