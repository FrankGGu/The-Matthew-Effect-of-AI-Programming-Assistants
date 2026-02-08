const MOD = 1000000007

func numOfArrays(n int, m int, k int) int {
	dp := make([][][]int, n+1)
	for i := range dp {
		dp[i] = make([][]int, m+1)
		for j := range dp[i] {
			dp[i][j] = make([]int, k+1)
			for l := range dp[i][j] {
				dp[i][j][l] = -1
			}
		}
	}

	var solve func(int, int, int) int
	solve = func(idx int, maxVal int, remain int) int {
		if idx == n {
			if remain == 0 {
				return 1
			}
			return 0
		}

		if dp[idx][maxVal][remain] != -1 {
			return dp[idx][maxVal][remain]
		}

		ans := 0
		for i := 1; i <= m; i++ {
			if i > maxVal {
				if remain > 0 {
					ans = (ans + solve(idx+1, i, remain-1)) % MOD
				}
			} else {
				ans = (ans + solve(idx+1, maxVal, remain)) % MOD
			}
		}

		dp[idx][maxVal][remain] = ans
		return ans
	}

	return solve(0, 0, k)
}