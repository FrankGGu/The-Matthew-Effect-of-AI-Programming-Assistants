func solve(grid []string) int {
	n := len(grid)
	m := len(grid[0])

	q := [][]int{{0, 0, 0}} // row, col, steps
	visited := make([][]bool, n)
	for i := range visited {
		visited[i] = make([]bool, m)
	}
	visited[0][0] = true

	dirs := [][]int{{0, 1}, {0, -1}, {1, 0}, {-1, 0}}

	for len(q) > 0 {
		curr := q[0]
		q = q[1:]
		row, col, steps := curr[0], curr[1], curr[2]

		if row == n-1 && col == m-1 {
			return steps
		}

		for _, dir := range dirs {
			newRow, newCol := row+dir[0], col+dir[1]

			if newRow >= 0 && newRow < n && newCol >= 0 && newCol < m && grid[newRow][newCol] == '.' && !visited[newRow][newCol] {
				q = append(q, []int{newRow, newCol, steps + 1})
				visited[newRow][newCol] = true
			}
		}
	}

	return -1
}