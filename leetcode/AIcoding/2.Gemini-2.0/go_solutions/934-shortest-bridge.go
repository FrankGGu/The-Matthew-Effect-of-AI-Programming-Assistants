func shortestBridge(grid [][]int) int {
	n := len(grid)
	var island []struct{ x, y int }
	found := false
	for i := 0; i < n; i++ {
		for j := 0; j < n; j++ {
			if grid[i][j] == 1 {
				dfs(grid, i, j, &island)
				found = true
				break
			}
		}
		if found {
			break
		}
	}

	q := make([]struct{ x, y int }, len(island))
	copy(q, island)

	dist := make([][]int, n)
	for i := range dist {
		dist[i] = make([]int, n)
	}

	for i := range island {
		dist[island[i].x][island[i].y] = 0
	}

	dx := []int{0, 0, 1, -1}
	dy := []int{1, -1, 0, 0}

	for len(q) > 0 {
		curr := q[0]
		q = q[1:]

		for i := 0; i < 4; i++ {
			nx := curr.x + dx[i]
			ny := curr.y + dy[i]

			if nx >= 0 && nx < n && ny >= 0 && ny < n {
				if grid[nx][ny] == 0 && dist[nx][ny] == 0 {
					dist[nx][ny] = dist[curr.x][curr.y] + 1
					q = append(q, struct{ x, y int }{nx, ny})
				} else if grid[nx][ny] == 1 && dist[nx][ny] == 0 {
					return dist[curr.x][curr.y]
				}
			}
		}
	}

	return -1
}

func dfs(grid [][]int, x, y int, island *[]struct{ x, y int }) {
	n := len(grid)
	if x < 0 || x >= n || y < 0 || y >= n || grid[x][y] != 1 {
		return
	}

	grid[x][y] = 2
	*island = append(*island, struct{ x, y int }{x, y})

	dfs(grid, x+1, y, island)
	dfs(grid, x-1, y, island)
	dfs(grid, x, y+1, island)
	dfs(grid, x, y-1, island)
}