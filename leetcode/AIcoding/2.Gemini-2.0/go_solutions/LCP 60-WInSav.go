func removeBoxes(boxes []int) int {
	n := len(boxes)
	dp := make([][][][]int, n)
	for i := range dp {
		dp[i] = make([][][]int, n)
		for j := range dp[i] {
			dp[i][j] = make([][]int, n)
			for k := range dp[i][j] {
				dp[i][j][k] = make([]int, n)
				for l := range dp[i][j][k] {
					dp[i][j][k][l] = -1
				}
			}
		}
	}

	var solve func(l, r, k int) int
	solve = func(l, r, k int) int {
		if l > r {
			return 0
		}
		if dp[l][r][k][n] != -1 {
			return dp[l][r][k][n]
		}

		for r > l && boxes[r] == boxes[r-1] {
			r--
			k++
		}

		res := solve(l, r-1, 0) + (k+1)*(k+1)

		for i := l; i < r; i++ {
			if boxes[i] == boxes[r] {
				res = max(res, solve(l, i-1, 0)+solve(i+1, r-1, k+1))
			}
		}

		dp[l][r][k][n] = res
		return res
	}

	return solve(0, n-1, 0)
}

func max(a, b int) int {
	if a > b {
		return a
	}
	return b
}