func max(a, b int) int {
	if a > b {
		return a
	}
	return b
}

func getMaximum(mice []int, holes []int) int {
	n := len(mice)
	m := len(holes)
	dp := make([][]int, n+1)
	for i := range dp {
		dp[i] = make([]int, m+1)
		for j := range dp[i] {
			dp[i][j] = -1
		}
	}

	var solve func(i, j int) int
	solve = func(i, j int) int {
		if i == n {
			return 0
		}
		if j == m {
			return -1000000000
		}
		if dp[i][j] != -1 {
			return dp[i][j]
		}

		dp[i][j] = max(solve(i, j+1), solve(i+1, j+1)+abs(mice[i]-holes[j]))
		return dp[i][j]
	}

	return solve(0, 0)
}

func abs(x int) int {
	if x < 0 {
		return -x
	}
	return x
}