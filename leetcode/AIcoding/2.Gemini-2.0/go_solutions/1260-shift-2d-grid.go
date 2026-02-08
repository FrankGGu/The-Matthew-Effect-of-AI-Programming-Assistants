func shiftGrid(grid [][]int, k int) [][]int {
	m := len(grid)
	n := len(grid[0])
	k %= (m * n)
	res := make([][]int, m)
	for i := range res {
		res[i] = make([]int, n)
	}

	for i := 0; i < m; i++ {
		for j := 0; j < n; j++ {
			newIndex := (i*n + j + k) % (m * n)
			newRow := newIndex / n
			newCol := newIndex % n
			res[newRow][newCol] = grid[i][j]
		}
	}

	return res
}