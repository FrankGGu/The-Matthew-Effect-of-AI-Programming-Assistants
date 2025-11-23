func checkGrid(grid [][]int, k int) bool {
	m, n := len(grid), len(grid[0])
	sums := make([][]int, m+1)
	for i := range sums {
		sums[i] = make([]int, n+1)
	}

	for i := 1; i <= m; i++ {
		for j := 1; j <= n; j++ {
			sums[i][j] = sums[i-1][j] + sums[i][j-1] - sums[i-1][j-1] + grid[i-1][j-1]
		}
	}

	for i := 0; i <= m-k; i++ {
		for j := 0; j <= n-k; j++ {
			count := sums[i+k][j+k] - sums[i+k][j] - sums[i][j+k] + sums[i][j]
			if count == 0 {
				return true
			}
		}
	}

	return false
}