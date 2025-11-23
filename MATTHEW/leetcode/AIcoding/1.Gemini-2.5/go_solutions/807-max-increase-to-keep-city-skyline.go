package main

func maxIncreaseKeepingSkyline(grid [][]int) int {
	n := len(grid)
	m := len(grid[0])

	maxRow := make([]int, n)
	maxCol := make([]int, m)

	for r := 0; r < n; r++ {
		for c := 0; c < m; c++ {
			if grid[r][c] > maxRow[r] {
				maxRow[r] = grid[r][c]
			}
			if grid[r][c] > maxCol[c] {
				maxCol[c] = grid[r][c]
			}
		}
	}

	totalIncrease := 0
	for r := 0; r < n; r++ {
		for c := 0; c < m; c++ {
			allowedHeight := maxRow[r]
			if maxCol[c] < allowedHeight {
				allowedHeight = maxCol[c]
			}
			totalIncrease += allowedHeight - grid[r][c]
		}
	}

	return totalIncrease
}