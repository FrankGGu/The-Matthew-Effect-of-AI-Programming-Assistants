package main

func countGoodStrings(low int, high int, zero int, one int) int {
	const MOD = 1_000_000_007
	dp := make([]int, high+1)
	dp[0] = 1 

	for i := 1; i <= high; i++ {
		if i >= zero {
			dp[i] = (dp[i] + dp[i-zero]) % MOD
		}
		if i >= one {
			dp[i] = (dp[i] + dp[i-one]) % MOD
		}
	}

	totalWays := 0
	for i := low; i <= high; i++ {
		totalWays = (totalWays + dp[i]) % MOD
	}

	return totalWays
}