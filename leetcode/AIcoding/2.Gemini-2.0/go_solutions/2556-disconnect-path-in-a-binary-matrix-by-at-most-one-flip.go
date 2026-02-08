func isPossibleToCutPath(grid [][]int) bool {
	m := len(grid)
	n := len(grid[0])

	if m == 1 && n == 1 {
		return false
	}

	var dfs func(int, int) bool
	visited := make([][]bool, m)
	for i := range visited {
		visited[i] = make([]bool, n)
	}

	dfs = func(r, c int) bool {
		if r == m-1 && c == n-1 {
			return true
		}

		visited[r][c] = true

		if r+1 < m && grid[r+1][c] == 1 && !visited[r+1][c] {
			if dfs(r+1, c) {
				return true
			}
		}

		if c+1 < n && grid[r][c+1] == 1 && !visited[r][c+1] {
			if dfs(r, c+1) {
				return true
			}
		}

		return false
	}

	grid[0][0] = 0
	if dfs(0, 0) {
		return true
	}

	grid[0][0] = 1
	visited = make([][]bool, m)
	for i := range visited {
		visited[i] = make([]bool, n)
	}

	grid[m-1][n-1] = 0

	if dfs(0, 0) {
		return true
	}
	grid[m-1][n-1] = 1

	return false
}