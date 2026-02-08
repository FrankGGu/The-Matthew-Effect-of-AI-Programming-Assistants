func fillGrid(n int, m int, k int) [][]int {
	grid := make([][]int, n)
	for i := range grid {
		grid[i] = make([]int, m)
	}

	if k == 0 {
		return grid
	}

	if n%2 == 0 && m%2 == 0 {
		if k%2 != 0 {
			return [][]int{}
		}
		for i := 0; i < n; i++ {
			for j := 0; j < m; j++ {
				grid[i][j] = k / 2
			}
		}
		return grid
	}

	if n%2 != 0 && m%2 != 0 {
		for i := 0; i < n; i++ {
			for j := 0; j < m; j++ {
				grid[i][j] = k % 2
			}
		}
		k -= (n * m) % 2
		if k < 0 {
			return [][]int{}
		}

		for i := 0; i < n; i++ {
			for j := 0; j < m; j++ {
				grid[i][j] += k / (n * m) * 2
			}
		}
		return grid
	}

	if n%2 == 0 {
		if k%2 != 0 {
			return [][]int{}
		}
		for i := 0; i < n; i++ {
			for j := 0; j < m; j++ {
				grid[i][j] = k / (n * m) * 2
			}
		}
		return grid
	}

	if m%2 == 0 {
		if k%2 != 0 {
			return [][]int{}
		}
		for i := 0; i < n; i++ {
			for j := 0; j < m; j++ {
				grid[i][j] = k / (n * m) * 2
			}
		}
		return grid
	}
	return grid
}