func numberOfPaths(grid [][]int, k int) int {
	m := len(grid)
	n := len(grid[0])
	MOD := 1_000_000_007

	// dp[i][j][rem] stores the number of paths from (0,0) to (i,j)
	// such that the sum of elements along the path has a remainder 'rem' when divided by 'k'.
	dp := make([][][]int, m)
	for i := range dp {
		dp[i] = make([][]int, n)
		for j := range dp[i] {
			dp[i][j] = make([]int, k)
		}
	}

	// Base case: For the starting cell (0,0)
	// There is one path to (0,0) with sum grid[0][0]
	initialRem := grid[0][0] % k
	dp[0][0][initialRem] = 1

	// Fill the first row
	for j := 1; j < n; j++ {
		currentVal := grid[0][j]
		for prevRem := 0; prevRem < k; prevRem++ {
			if dp[0][j-1][prevRem] > 0 {
				newRem := (prevRem + currentVal) % k
				dp[0][j][newRem] = (dp[0][j][newRem] + dp[0][j-1][prevRem]) % MOD
			}
		}
	}

	// Fill the first column
	for i := 1; i < m; i++ {
		currentVal := grid[i][0]
		for prevRem := 0; prevRem < k; prevRem++ {
			if dp[i-1][0][prevRem] > 0 {
				newRem := (prevRem + currentVal) % k
				dp[i][0][newRem] = (dp[i][0][newRem] + dp[i-1][0][prevRem]) % MOD
			}
		}
	}

	// Fill the rest of the DP table
	for i := 1; i < m; i++ {
		for j := 1; j < n; j++ {
			currentVal := grid[i][j]
			for prevRem := 0; prevRem < k; prevRem++ {
				// From top (i-1, j)
				if dp[i-1][j][prevRem] > 0 {
					newRem := (prevRem + currentVal) % k
					dp[i][j][newRem] = (dp[i][j][newRem] + dp[i-1][j][prevRem]) % MOD
				}
				// From left (i, j-1)
				if dp[i][j-1][prevRem] > 0 {
					newRem := (prevRem + currentVal) % k
					dp[i][j][newRem] = (dp[i][j][newRem] + dp[i][j-1][prevRem]) % MOD
				}
			}
		}
	}

	// The result is the number of paths to (m-1, n-1) with remainder 0
	return dp[m-1][n-1][0]
}