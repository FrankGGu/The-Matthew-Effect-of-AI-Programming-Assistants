func numberWays(hats [][]int) int {
	n := len(hats)
	mod := 1000000007
	maxHat := 0
	for _, h := range hats {
		for _, x := range h {
			if x > maxHat {
				maxHat = x
			}
		}
	}

	hatToPeople := make([][]int, maxHat+1)
	for i := 0; i < n; i++ {
		for _, hat := range hats[i] {
			hatToPeople[hat] = append(hatToPeople[hat], i)
		}
	}

	dp := make([][]int, maxHat+1)
	for i := range dp {
		dp[i] = make([]int, 1<<n)
	}
	dp[0][0] = 1

	for i := 1; i <= maxHat; i++ {
		for mask := 0; mask < (1 << n); mask++ {
			dp[i][mask] = (dp[i][mask] + dp[i-1][mask]) % mod
			for _, p := range hatToPeople[i] {
				if (mask & (1 << p)) > 0 {
					dp[i][mask] = (dp[i][mask] + dp[i-1][mask^(1<<p)]) % mod
				}
			}
		}
	}

	return dp[maxHat][(1<<n)-1]
}