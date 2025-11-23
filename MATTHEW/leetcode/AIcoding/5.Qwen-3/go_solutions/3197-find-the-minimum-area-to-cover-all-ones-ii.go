package main

func minimumArea(grid [][]int) int {
	rows := make(map[int]bool)
	cols := make(map[int]bool)

	for i := 0; i < len(grid); i++ {
		for j := 0; j < len(grid[0]); j++ {
			if grid[i][j] == 1 {
				rows[i] = true
				cols[j] = true
			}
		}
	}

	minRow, maxRow := -1, -1
	for r := range rows {
		if minRow == -1 || r < minRow {
			minRow = r
		}
		if maxRow == -1 || r > maxRow {
			maxRow = r
		}
	}

	minCol, maxCol := -1, -1
	for c := range cols {
		if minCol == -1 || c < minCol {
			minCol = c
		}
		if maxCol == -1 || c > maxCol {
			maxCol = c
		}
	}

	return (maxRow - minRow + 1) * (maxCol - minCol + 1)
}