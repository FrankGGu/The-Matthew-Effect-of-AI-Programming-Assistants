func onesMinusZeros(grid [][]int) [][]int {
	m := len(grid)
	n := len(grid[0])

	onesRow := make([]int, m)
	onesCol := make([]int, n)

	for i := 0; i < m; i++ {
		for j := 0; j < n; j++ {
			if grid[i][j] == 1 {
				onesRow[i]++
				onesCol[j]++
			}
		}
	}

	diff := make([][]int, m)
	for i := 0; i < m; i++ {
		diff[i] = make([]int, n)
		for j := 0; j < n; j++ {
			diff[i][j] = 2*onesRow[i] + 2*onesCol[j] - m - n
		}
	}

	return diff
}