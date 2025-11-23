func containsCycle(grid [][]byte) bool {
	m, n := len(grid), len(grid[0])
	visited := make([][]bool, m)
	for i := range visited {
		visited[i] = make([]bool, n)
	}

	var dfs func(int, int, int, int, byte) bool
	dfs = func(i, j, pi, pj int, char byte) bool {
		if i < 0 || i >= m || j < 0 || j >= n || grid[i][j] != char {
			return false
		}
		if visited[i][j] {
			return true
		}

		visited[i][j] = true

		directions := [][]int{{0, 1}, {0, -1}, {1, 0}, {-1, 0}}
		for _, dir := range directions {
			ni, nj := i+dir[0], j+dir[1]
			if ni >= 0 && ni < m && nj >= 0 && nj < n && (ni != pi || nj != pj) {
				if dfs(ni, nj, i, j, char) {
					return true
				}
			}
		}

		return false
	}

	for i := 0; i < m; i++ {
		for j := 0; j < n; j++ {
			if !visited[i][j] {
				if dfs(i, j, -1, -1, grid[i][j]) {
					return true
				}
			}
		}
	}

	return false
}