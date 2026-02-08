func stoneGameII(piles []int) int {
	n := len(piles)
	dp := make([]int, n+1)
	for i := n - 1; i >= 0; i-- {
		total := 0
		for x := 1; x <= 2; x++ {
			if i+x <= n {
				total += piles[i]
				dp[i] = max(dp[i], total-sum(piles, i+x, n)+dp[i+x])
			}
		}
	}
	return dp[0]
}

func sum(piles []int, start int, end int) int {
	total := 0
	for i := start; i < end; i++ {
		total += piles[i]
	}
	return total
}

func max(a, b int) int {
	if a > b {
		return a
	}
	return b
}