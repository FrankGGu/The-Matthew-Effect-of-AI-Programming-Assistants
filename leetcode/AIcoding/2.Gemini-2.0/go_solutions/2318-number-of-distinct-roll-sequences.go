func distinctSequences(n int) int {
	const mod int = 1e9 + 7
	dp := make([][6][6]int, n+1)
	for i := 0; i < 6; i++ {
		for j := 0; j < 6; j++ {
			dp[1][i][j] = 1
		}
	}

	for i := 2; i <= n; i++ {
		for j := 0; j < 6; j++ {
			for k := 0; k < 6; k++ {
				for l := 0; l < 6; l++ {
					if l != j && l != k && gcd(l+1, j+1) == 1 {
						dp[i][j][l] = (dp[i][j][l] + dp[i-1][k][j]) % mod
					}
				}
			}
		}
	}

	ans := 0
	for i := 0; i < 6; i++ {
		for j := 0; j < 6; j++ {
			ans = (ans + dp[n][i][j]) % mod
		}
	}
	return ans
}

func gcd(a, b int) int {
	for b != 0 {
		a, b = b, a%b
	}
	return a
}