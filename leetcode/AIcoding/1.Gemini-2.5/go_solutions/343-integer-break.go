package main

func max(a, b int) int {
	if a > b {
		return a
	}
	return b
}

func integerBreak(n int) int {
	if n == 2 {
		return 1
	}
	if n == 3 {
		return 2
	}

	dp := make([]int, n+1)
	// dp[1] is effectively 1, meaning the number 1 itself.
	// It's used when breaking n into j and 1, where 1 is not further broken.
	// dp[1] = 1
	dp[2] = 1 // 2 = 1 + 1, product 1*1 = 1
	dp[3] = 2 // 3 = 1 + 2, product 1*2 = 2 (3 = 1+1+1, product 1*1*1 = 1)

	for i := 4; i <= n; i++ {
		maxProduct := 0
		for j := 1; j < i; j++ {
			// Option 1: Break i into j and (i-j), where (i-j) is treated as a single number (not broken further).
			// This is j * (i-j).
			// Option 2: Break i into j and (i-j), where (i-j) is broken down to its maximum product (dp[i-j]).
			// This is j * dp[i-j].
			// We take the maximum of these two options for the current j.
			currentProduct := max(j*(i-j), j*dp[i-j])
			maxProduct = max(maxProduct, currentProduct)
		}
		dp[i] = maxProduct
	}

	return dp[n]
}