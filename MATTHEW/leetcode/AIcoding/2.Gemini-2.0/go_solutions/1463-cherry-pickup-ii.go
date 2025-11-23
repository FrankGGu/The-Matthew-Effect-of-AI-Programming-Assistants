import "fmt"

func cherryPickup(grid [][]int) int {
	m := len(grid)
	n := len(grid[0])
	dp := make([][][]int, m)
	for i := range dp {
		dp[i] = make([][]int, n)
		for j := range dp[i] {
			dp[i][j] = make([]int, n)
			for k := range dp[i][j] {
				dp[i][j][k] = -1
			}
		}
	}

	var solve func(row, col1, col2 int) int
	solve = func(row, col1, col2 int) int {
		if row == m {
			return 0
		}
		if col1 < 0 || col1 >= n || col2 < 0 || col2 >= n {
			return -1
		}
		if dp[row][col1][col2] != -1 {
			return dp[row][col1][col2]
		}

		cherries := grid[row][col1]
		if col1 != col2 {
			cherries += grid[row][col2]
		}

		maxCherries := -1
		for i := -1; i <= 1; i++ {
			for j := -1; j <= 1; j++ {
				nextCol1 := col1 + i
				nextCol2 := col2 + j
				nextCherries := solve(row+1, nextCol1, nextCol2)
				if nextCherries != -1 {
					maxCherries = max(maxCherries, nextCherries)
				}
			}
		}

		if maxCherries != -1 {
			dp[row][col1][col2] = cherries + maxCherries
		} else {
			dp[row][col1][col2] = -1
		}

		return dp[row][col1][col2]
	}

	return solve(0, 0, n-1)
}

func max(a, b int) int {
	if a > b {
		return a
	}
	return b
}