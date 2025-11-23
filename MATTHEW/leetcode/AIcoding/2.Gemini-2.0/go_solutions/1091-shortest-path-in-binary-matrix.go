func shortestPathBinaryMatrix(grid [][]int) int {
	n := len(grid)
	if grid[0][0] == 1 || grid[n-1][n-1] == 1 {
		return -1
	}

	q := [][]int{{0, 0, 1}}
	grid[0][0] = 1

	for len(q) > 0 {
		curr := q[0]
		q = q[1:]
		r, c, dist := curr[0], curr[1], curr[2]

		if r == n-1 && c == n-1 {
			return dist
		}

		for i := -1; i <= 1; i++ {
			for j := -1; j <= 1; j++ {
				if i == 0 && j == 0 {
					continue
				}
				newR, newC := r+i, c+j
				if newR >= 0 && newR < n && newC >= 0 && newC < n && grid[newR][newC] == 0 {
					grid[newR][newC] = 1
					q = append(q, []int{newR, newC, dist + 1})
				}
			}
		}
	}

	return -1
}