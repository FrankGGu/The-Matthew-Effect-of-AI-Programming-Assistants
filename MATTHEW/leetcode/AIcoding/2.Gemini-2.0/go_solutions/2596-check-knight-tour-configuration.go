func checkKnightTour(grid [][]int) bool {
	n := len(grid)
	if n == 0 {
		return true
	}
	m := len(grid[0])
	if m == 0 {
		return true
	}

	if grid[0][0] != 0 {
		return false
	}

	x := 0
	y := 0

	for i := 1; i < n*m; i++ {
		found := false
		dx := []int{-2, -2, -1, -1, 1, 1, 2, 2}
		dy := []int{-1, 1, -2, 2, -2, 2, -1, 1}

		for j := 0; j < 8; j++ {
			nx := x + dx[j]
			ny := y + dy[j]

			if nx >= 0 && nx < n && ny >= 0 && ny < m && grid[nx][ny] == i {
				x = nx
				y = ny
				found = true
				break
			}
		}
		if !found {
			return false
		}
	}

	return true
}