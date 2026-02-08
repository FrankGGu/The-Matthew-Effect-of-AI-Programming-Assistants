func colorBorder(grid [][]int, row int, col int, color int) [][]int {
	m, n := len(grid), len(grid[0])
	visited := make([][]bool, m)
	for i := range visited {
		visited[i] = make([]bool, n)
	}

	originalColor := grid[row][col]
	borders := [][]int{}

	var dfs func(int, int)
	dfs = func(r, c int) {
		if r < 0 || r >= m || c < 0 || c >= n || visited[r][c] || grid[r][c] != originalColor {
			return
		}

		visited[r][c] = true
		isBorder := false

		if r == 0 || r == m-1 || c == 0 || c == n-1 {
			isBorder = true
		} else if grid[r-1][c] != originalColor || grid[r+1][c] != originalColor || grid[r][c-1] != originalColor || grid[r][c+1] != originalColor {
			isBorder = true
		}

		if isBorder {
			borders = append(borders, []int{r, c})
		}

		dfs(r+1, c)
		dfs(r-1, c)
		dfs(r, c+1)
		dfs(r, c-1)
	}

	dfs(row, col)

	for _, border := range borders {
		grid[border[0]][border[1]] = color
	}

	return grid
}