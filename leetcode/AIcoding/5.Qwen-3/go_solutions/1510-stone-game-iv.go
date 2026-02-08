package main

func winnerSquareDrop(n int) bool {
	dp := make([]bool, n+1)
	for i := 1; i <= n; i++ {
		j := 1
		for j*j <= i {
			if !dp[i-j*j] {
				dp[i] = true
				break
			}
			j++
		}
	}
	return dp[n]
}