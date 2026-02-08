func minCoin(coins []int) int {
	totalCoins := 0
	for _, c := range coins {
		// For each pile c, we can take floor(c/2) or c - floor(c/2) coins.
		// We want to minimize the coins taken from this pile, but must take at least