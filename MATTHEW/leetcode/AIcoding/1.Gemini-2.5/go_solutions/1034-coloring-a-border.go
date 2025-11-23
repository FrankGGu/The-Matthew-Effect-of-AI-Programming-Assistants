func colorBorder(grid [][]int, r0 int, c0 int, color int) [][]int {
	m := len(grid)
	n := len(grid[0])
	targetColor := grid[r0][c0]

	visited := make([][]bool, m)
	for i := range visited {
		visited[i] = make([]bool, n)
	}

	borderCells := [][]int{}

	dr := []int{-1, 1, 0, 0}
	dc := []int{0, 0, -1, 1}

	var dfs func(r, c int)
	dfs = func(r, c int) {
		visited[r][c] = true

		isBorder := false

		for i := 0; i < 4; i++ {
			nr, nc := r + dr[i], c + dc[i]

			if nr < 0 || nr >= m || nc < 0 || nc >= n {
				isBorder = true
				continue
			}

			if grid[nr][nc] != targetColor {
				isBorder = true
			} else {
				if !visited[nr][nc] {
					dfs(nr, nc)
				}
			}
		}

		if isBorder {
			borderCells = append(borderCells, []int{r, c})
		}
	}

	dfs(r0, c0)

	for _, cell := range borderCells {
		grid[cell[0]][cell[1]] = color
	}

	return grid
}