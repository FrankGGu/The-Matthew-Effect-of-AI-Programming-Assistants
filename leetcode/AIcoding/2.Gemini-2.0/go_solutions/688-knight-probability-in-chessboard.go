func knightProbability(n int, k int, row int, column int) float64 {
	dp := make([][]float64, n)
	for i := range dp {
		dp[i] = make([]float64, n)
	}
	dp[row][column] = 1.0

	directions := [][]int{
		{-2, -1}, {-2, 1}, {-1, -2}, {-1, 2},
		{1, -2}, {1, 2}, {2, -1}, {2, 1},
	}

	for step := 0; step < k; step++ {
		newDp := make([][]float64, n)
		for i := range newDp {
			newDp[i] = make([]float64, n)
		}

		for r := 0; r < n; r++ {
			for c := 0; c < n; c++ {
				for _, dir := range directions {
					prevR := r - dir[0]
					prevC := c - dir[1]

					if prevR >= 0 && prevR < n && prevC >= 0 && prevC < n {
						newDp[r][c] += dp[prevR][prevC] / 8.0
					}
				}
			}
		}

		dp = newDp
	}

	var totalProbability float64
	for r := 0; r < n; r++ {
		for c := 0; c < n; c++ {
			totalProbability += dp[r][c]
		}
	}

	return totalProbability
}