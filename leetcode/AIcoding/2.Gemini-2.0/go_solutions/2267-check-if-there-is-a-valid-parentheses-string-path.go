func hasValidPath(grid [][]byte) bool {
	m, n := len(grid), len(grid[0])
	if (m+n)%2 == 0 {
		return false
	}
	if grid[0][0] == ')' || grid[m-1][n-1] == '(' {
		return false
	}

	dp := make([][][]bool, m)
	for i := range dp {
		dp[i] = make([][]bool, n)
		for j := range dp[i] {
			dp[i][j] = make([]bool, m+n)
		}
	}

	dp[0][0][1] = true

	for sum := 1; sum < m+n; sum++ {
		for i := 0; i < m; i++ {
			j := sum - i
			if j < 0 || j >= n {
				continue
			}
			if grid[i][j] == '(' {
				for k := 0; k < m+n-1; k++ {
					if i > 0 && dp[i-1][j][k] {
						dp[i][j][k+1] = true
					}
					if j > 0 && dp[i][j-1][k] {
						dp[i][j][k+1] = true
					}
				}
			} else {
				for k := 1; k < m+n; k++ {
					if i > 0 && dp[i-1][j][k] {
						dp[i][j][k-1] = true
					}
					if j > 0 && dp[i][j-1][k] {
						dp[i][j][k-1] = true
					}
				}
			}
		}
	}

	return dp[m-1][n-1][0]
}