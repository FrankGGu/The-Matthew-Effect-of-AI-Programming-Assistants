func ways(pizza []string, k int) int {
	R := len(pizza)
	C := len(pizza[0])
	MOD := 1_000_000_007

	// apples[r][c] stores the number of apples in the sub-pizza pizza[r:][c:]
	apples := make([][]int, R+1)
	for i := range apples {
		apples[i] = make([]int, C+1)
	}

	for r := R - 1; r >= 0; r-- {
		for c := C - 1; c >= 0; c-- {
			currentApple := 0
			if pizza[r][c] == 'A' {
				currentApple = 1
			}
			apples[r][c] = currentApple + apples[r+1][c] + apples[r][c+1] - apples[r+1][c+1]
		}
	}

	// dp[k][r][c] stores the number of ways to cut the sub-pizza pizza[r:][c:] into k pieces
	dp := make([][][]int, k+1)
	for i := range dp {
		dp[i] = make([][]int, R)
		for j := range dp[i] {
			dp[i][j] = make([]int, C)
		}
	}

	// Base case: k = 1. If the sub-pizza has apples, there's 1 way (take the whole piece).
	for r := 0; r < R; r++ {
		for c := 0; c < C; c++ {
			if apples[r][c] > 0 {
				dp[1][r][c] = 1
			}
		}
	}

	// Fill DP table for k from 2 to K
	for currentK := 2; currentK <= k; currentK++ {
		for r := R - 1; r >= 0; r-- {
			for c := C - 1; c >= 0; c-- {
				// If the current sub-pizza has no apples, it cannot be cut into pieces with apples.
				if apples[r][c] == 0 {
					continue
				}

				// Try horizontal cuts
				for nextR := r + 1; nextR < R; nextR++ {
					// Check if the top piece (pizza[r:nextR][c:]) has at least one apple
					if apples[r][c]-apples[nextR][c] > 0 {
						dp[currentK][r][c] = (dp[currentK][r][c] + dp[currentK-1][nextR][c]) % MOD
					}
				}

				// Try vertical cuts
				for nextC := c + 1; nextC < C; nextC++ {
					// Check if the left piece (pizza[r:][c:nextC]) has at least one apple
					if apples[r][c]-apples[r][nextC] > 0 {
						dp[currentK][r][c] = (dp[currentK][r][c] + dp[currentK-1][r][nextC]) % MOD
					}
				}
			}
		}
	}

	return dp[k][0][0]
}