func ways(pizza []string, k int) int {
	m, n := len(pizza), len(pizza[0])
	apples := make([][]int, m+1)
	for i := range apples {
		apples[i] = make([]int, n+1)
	}
	for i := m - 1; i >= 0; i-- {
		for j := n - 1; j >= 0; j-- {
			apples[i][j] = apples[i+1][j] + apples[i][j+1] - apples[i+1][j+1]
			if pizza[i][j] == 'A' {
				apples[i][j]++
			}
		}
	}

	dp := make([][][]int, k)
	for i := range dp {
		dp[i] = make([][]int, m)
		for j := range dp[i] {
			dp[i][j] = make([]int, n)
			for l := range dp[i][j] {
				dp[i][j][l] = -1
			}
		}
	}

	var solve func(int, int, int) int
	solve = func(rem int, row int, col int) int {
		if apples[row][col] == 0 {
			return 0
		}
		if rem == 1 {
			return 1
		}
		if dp[rem-1][row][col] != -1 {
			return dp[rem-1][row][col]
		}

		ans := 0
		for i := row + 1; i < m; i++ {
			if apples[row][col]-apples[i][col] > 0 {
				ans = (ans + solve(rem-1, i, col)) % 1000000007
			}
		}
		for j := col + 1; j < n; j++ {
			if apples[row][col]-apples[row][j] > 0 {
				ans = (ans + solve(rem-1, row, j)) % 1000000007
			}
		}

		dp[rem-1][row][col] = ans
		return ans
	}

	return solve(k, 0, 0)
}