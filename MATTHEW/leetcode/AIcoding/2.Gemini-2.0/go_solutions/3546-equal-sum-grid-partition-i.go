func equalSumGrid(grid [][]int) bool {
	n := len(grid)
	prefixRow := make([][]int, n)
	for i := range prefixRow {
		prefixRow[i] = make([]int, n+1)
		for j := 0; j < n; j++ {
			prefixRow[i][j+1] = prefixRow[i][j] + grid[i][j]
		}
	}

	prefixCol := make([][]int, n+1)
	for i := range prefixCol {
		prefixCol[i] = make([]int, n)
		for j := 0; j < n; j++ {
			if i > 0 {
				prefixCol[i][j] = prefixCol[i-1][j] + grid[i-1][j]
			}
		}
	}

	for i := 1; i < n; i++ {
		for j := 1; j < n; j++ {
			top := prefixCol[i][j-1]
			bottom := prefixCol[n][j-1] - top
			left := 0
			for k := 0; k < i; k++ {
				left += prefixRow[k][j]
			}
			right := 0
			for k := 0; k < i; k++ {
				right += prefixRow[k][n] - prefixRow[k][j]
			}
			bottomLeft := 0
			for k := i; k < n; k++ {
				bottomLeft += prefixRow[k][j]
			}
			bottomRight := 0
			for k := i; k < n; k++ {
				bottomRight += prefixRow[k][n] - prefixRow[k][j]
			}
			if top == bottom && left == right && bottomLeft == bottomRight && top == left {
				return true
			}
		}
	}
	return false
}