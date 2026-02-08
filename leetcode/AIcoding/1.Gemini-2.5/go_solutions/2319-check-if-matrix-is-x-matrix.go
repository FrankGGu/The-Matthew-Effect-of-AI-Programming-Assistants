func checkXMatrix(grid [][]int) bool {
	n := len(grid)
	for r := 0; r < n; r++ {
		for c := 0; c < n; c++ {
			isOnDiagonal := (r == c || r+c == n-1)
			if isOnDiagonal {
				if grid[r][c] == 0 {
					return false
				}
			} else {
				if grid[r][c] != 0 {
					return false
				}
			}
		}
	}
	return true
}