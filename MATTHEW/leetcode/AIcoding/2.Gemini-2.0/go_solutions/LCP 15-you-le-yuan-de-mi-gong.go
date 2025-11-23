func hasPath(maze [][]int, start []int, destination []int) bool {
	m, n := len(maze), len(maze[0])
	visited := make([][]bool, m)
	for i := range visited {
		visited[i] = make([]bool, n)
	}

	var dfs func(int, int) bool
	dfs = func(x, y int) bool {
		if visited[x][y] {
			return false
		}
		if x == destination[0] && y == destination[1] {
			return true
		}
		visited[x][y] = true

		directions := [][]int{{0, 1}, {0, -1}, {1, 0}, {-1, 0}}
		for _, dir := range directions {
			dx, dy := dir[0], dir[1]
			nx, ny := x, y
			for nx >= 0 && nx < m && ny >= 0 && ny < n && maze[nx][ny] == 0 {
				nx += dx
				ny += dy
			}
			nx -= dx
			ny -= dy
			if dfs(nx, ny) {
				return true
			}
		}
		return false
	}

	return dfs(start[0], start[1])
}