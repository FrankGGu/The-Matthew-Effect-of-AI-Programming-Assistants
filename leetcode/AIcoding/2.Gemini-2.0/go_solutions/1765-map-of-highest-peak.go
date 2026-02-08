func highestPeak(isWater [][]int) [][]int {
	m, n := len(isWater), len(isWater[0])
	heights := make([][]int, m)
	for i := range heights {
		heights[i] = make([]int, n)
		for j := range heights[i] {
			heights[i][j] = -1
		}
	}

	q := []struct{ x, y int }{}
	for i := 0; i < m; i++ {
		for j := 0; j < n; j++ {
			if isWater[i][j] == 1 {
				heights[i][j] = 0
				q = append(q, struct{ x, y int }{i, j})
			}
		}
	}

	dirs := []struct{ x, y int }{
		{0, 1}, {0, -1}, {1, 0}, {-1, 0},
	}

	for len(q) > 0 {
		curr := q[0]
		q = q[1:]

		for _, dir := range dirs {
			nx, ny := curr.x+dir.x, curr.y+dir.y
			if nx >= 0 && nx < m && ny >= 0 && ny < n && heights[nx][ny] == -1 {
				heights[nx][ny] = heights[curr.x][curr.y] + 1
				q = append(q, struct{ x, y int }{nx, ny})
			}
		}
	}

	return heights
}