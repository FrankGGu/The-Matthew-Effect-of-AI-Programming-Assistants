package main

func profitableSchemes(n int, minProfit int, group []int, profit []int) int {
	const MOD = 1e9 + 7

	dp := make([][]int, n+1)
	for i := range dp {
		dp[i] = make([]int, minProfit+1)
	}

	dp[0][0] = 1

	for i := 0; i < len(group); i++ {
		g := group[i]
		p := profit[i]

		for j := n; j >= g; j-- {
			for k := minProfit; k >= 0; k-- {
				newProfit := min(minProfit, k+p)
				dp[j][newProfit] = (dp[j][newProfit] + dp[j-g][k]) % MOD
			}
		}
	}

	totalSchemes := 0
	for j := 0; j <= n; j++ {
		totalSchemes = (totalSchemes + dp[j][minProfit]) % MOD
	}

	return totalSchemes
}

func min(a, b int) int {
	if a < b {
		return a
	}
	return b
}