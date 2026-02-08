func largestMagicSquare(grid [][]int) int {
	n := len(grid)
	m := len(grid[0])
	sumRow := make([][]int, n+1)
	sumCol := make([][]int, m+1)
	for i := 0; i <= n; i++ {
		sumRow[i] = make([]int, m+1)
	}
	for i := 0; i <= m; i++ {
		sumCol[i] = make([]int, n+1)
	}
	for i := 1; i <= n; i++ {
		for j := 1; j <= m; j++ {
			sumRow[i][j] = sumRow[i][j-1] + grid[i-1][j-1]
			sumCol[j][i] = sumCol[j][i-1] + grid[i-1][j-1]
		}
	}

	maxSize := min(n, m)
	for k := maxSize; k >= 1; k-- {
		for i := 1; i <= n-k+1; i++ {
			for j := 1; j <= m-k+1; j++ {
				targetSum := sumRow[i][j+k-1] - sumRow[i][j-1]
				ok := true
				for row := i + 1; row <= i+k-1; row++ {
					if sumRow[row][j+k-1]-sumRow[row][j-1] != targetSum {
						ok = false
						break
					}
				}
				if !ok {
					continue
				}
				for col := j; col <= j+k-1; col++ {
					if sumCol[col][i+k-1]-sumCol[col][i-1] != targetSum {
						ok = false
						break
					}
				}
				if !ok {
					continue
				}
				diag1 := 0
				for l := 0; l < k; l++ {
					diag1 += grid[i+l-1][j+l-1]
				}
				if diag1 != targetSum {
					continue
				}
				diag2 := 0
				for l := 0; l < k; l++ {
					diag2 += grid[i+l-1][j+k-1-l-1]
				}
				if diag2 != targetSum {
					continue
				}
				return k
			}
		}
	}
	return 1
}

func min(a, b int) int {
	if a < b {
		return a
	}
	return b
}