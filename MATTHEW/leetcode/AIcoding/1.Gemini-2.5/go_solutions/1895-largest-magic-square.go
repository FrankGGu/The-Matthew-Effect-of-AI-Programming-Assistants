func largestMagicSquare(grid [][]int) int {
	m := len(grid)
	n := len(grid[0])

	if m == 0 || n == 0 {
		return 0
	}

	rowPrefix := make([][]int, m)
	for i := range rowPrefix {
		rowPrefix[i] = make([]int, n+1)
		for j := 0; j < n; j++ {
			rowPrefix[i][j+1] = rowPrefix[i][j] + grid[i][j]
		}
	}

	colPrefix := make([][]int, m+1)
	for i := range colPrefix {
		colPrefix[i] = make([]int, n)
	}
	for j := 0; j < n; j++ {
		for i := 0; i < m; i++ {
			colPrefix[i+1][j] = colPrefix[i][j] + grid[i][j]
		}
	}

	diag1Prefix := make([][]int, m)
	for i := range diag1Prefix {
		diag1Prefix[i] = make([]int, n)
	}
	for i := 0; i < m; i++ {
		for j := 0; j < n; j++ {
			diag1Prefix[i][j] = grid[i][j]
			if i > 0 && j > 0 {
				diag1Prefix[i][j] += diag1Prefix[i-1][j-1]
			}
		}
	}

	diag2Prefix := make([][]int, m)
	for i := range diag2Prefix {
		diag2Prefix[i] = make([]int, n)
	}
	for i := 0; i < m; i++ {
		for j := n - 1; j >= 0; j-- {
			diag2Prefix[i][j] = grid[i][j]
			if i > 0 && j < n-1 {
				diag2Prefix[i][j] += diag2Prefix[i-1][j+1]
			}
		}
	}

	for k := min(m, n); k >= 2; k-- {
		for r := 0; r <= m-k; r++ {
			for c := 0; c <= n-k; c++ {
				if isMagic(r, c, k, grid, rowPrefix, colPrefix, diag1Prefix, diag2Prefix) {
					return k
				}
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

func isMagic(r, c, k int, grid [][]int, rowPrefix, colPrefix, diag1Prefix, diag2Prefix [][]int) bool {
	R := r + k - 1
	C := c + k - 1

	targetSum := rowPrefix[r][C+1] - rowPrefix[r][c]

	for i := r + 1; i <= R; i++ {
		if rowPrefix[i][C+1]-rowPrefix[i][c] != targetSum {
			return false
		}
	}

	for j := c; j <= C; j++ {
		if colPrefix[R+1][j]-colPrefix[r][j] != targetSum {
			return false
		}
	}

	diag1Sum := diag1Prefix[R][C]
	if r > 0 && c > 0 {
		diag1Sum -= diag1Prefix[r-1][c-1]
	}
	if diag1Sum != targetSum {
		return false
	}

	diag2Sum := diag2Prefix[R][c]
	if r > 0 && C < len(grid[0])-1 {
		diag2Sum -= diag2Prefix[r-1][C+1]
	}
	if diag2Sum != targetSum {
		return false
	}

	return true
}