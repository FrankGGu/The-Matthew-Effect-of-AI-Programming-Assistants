func findBall(grid [][]int) []int {
	m := len(grid)
	n := len(grid[0])
	result := make([]int, n)

	for startCol := 0; startCol < n; startCol++ {
		currentCol := startCol
		stuck := false

		for row := 0; row < m; row++ {
			val := grid[row][currentCol]

			if val == 1 { // '\' board, moves right
				// Check for right wall or V-shape trap
				if currentCol == n-1 || grid[row][currentCol+1] == -1 {
					stuck = true
					break
				}
				currentCol++
			} else { // val == -1, '/' board, moves left
				// Check for left wall or V-shape trap
				if currentCol == 0 || grid[row][currentCol-1] == 1 {
					stuck = true
					break
				}
				currentCol--
			}
		}

		if stuck {
			result[startCol] = -1
		} else {
			result[startCol] = currentCol
		}
	}

	return result
}