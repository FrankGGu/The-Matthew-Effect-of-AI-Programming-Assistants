func countSubmatrices(grid [][]int, k int) int {
	m := len(grid)
	n := len(grid[0])
	count := 0
	prefixSum := make([][]int, m+1)
	for i := 0; i <= m; i++ {
		prefixSum[i] = make([]int, n+1)
	}

	for i := 1; i <= m; i++ {
		for j := 1; j <= n; j++ {
			prefixSum[i][j] = prefixSum[i-1][j] + prefixSum[i][j-1] - prefixSum[i-1][j-1] + grid[i-1][j-1]
		}
	}

	for i := 1; i <= m; i++ {
		for j := 1; j <= n; j++ {
			for row := i; row <= m; row++ {
				for col := j; col <= n; col++ {
					sum := prefixSum[row][col] - prefixSum[i-1][col] - prefixSum[row][j-1] + prefixSum[i-1][j-1]
					if sum <= k {
						count++
					}
				}
			}
		}
	}

	return count
}