func orderOfLargestPlusSign(n int, mines [][]int) int {
	grid := make([][]int, n)
	for i := range grid {
		grid[i] = make([]int, n)
		for j := range grid[i] {
			grid[i][j] = 1
		}
	}

	for _, mine := range mines {
		grid[mine[0]][mine[1]] = 0
	}

	dp := make([][][]int, n)
	for i := range dp {
		dp[i] = make([][]int, n)
		for j := range dp[i] {
			dp[i][j] = make([]int, 4)
		}
	}

	for i := 0; i < n; i++ {
		count := 0
		for j := 0; j < n; j++ {
			if grid[i][j] == 1 {
				count++
			} else {
				count = 0
			}
			dp[i][j][0] = count
		}
		count = 0
		for j := n - 1; j >= 0; j-- {
			if grid[i][j] == 1 {
				count++
			} else {
				count = 0
			}
			dp[i][j][1] = count
		}
	}

	for j := 0; j < n; j++ {
		count := 0
		for i := 0; i < n; i++ {
			if grid[i][j] == 1 {
				count++
			} else {
				count = 0
			}
			dp[i][j][2] = count
		}
		count = 0
		for i := n - 1; i >= 0; i-- {
			if grid[i][j] == 1 {
				count++
			} else {
				count = 0
			}
			dp[i][j][3] = count
		}
	}

	ans := 0
	for i := 0; i < n; i++ {
		for j := 0; j < n; j++ {
			minVal := dp[i][j][0]
			minVal = min(minVal, dp[i][j][1])
			minVal = min(minVal, dp[i][j][2])
			minVal = min(minVal, dp[i][j][3])
			ans = max(ans, minVal)
		}
	}

	return ans
}

func min(a, b int) int {
	if a < b {
		return a
	}
	return b
}

func max(a, b int) int {
	if a > b {
		return a
	}
	return b
}