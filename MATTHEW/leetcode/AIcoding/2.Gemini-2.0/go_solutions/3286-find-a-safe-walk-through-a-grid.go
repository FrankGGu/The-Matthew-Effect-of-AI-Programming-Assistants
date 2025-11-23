func findSafeWalk(grid [][]int) []int {
	n := len(grid)
	m := len(grid[0])

	dist := make([][]int, n)
	for i := range dist {
		dist[i] = make([]int, m)
		for j := range dist[i] {
			dist[i][j] = int(1e9)
		}
	}

	q := []struct{ x, y int }{}
	for i := 0; i < n; i++ {
		for j := 0; j < m; j++ {
			if grid[i][j] == 1 {
				dist[i][j] = 0
				q = append(q, struct{ x, y int }{i, j})
			}
		}
	}

	dx := []int{0, 0, 1, -1}
	dy := []int{1, -1, 0, 0}

	for len(q) > 0 {
		curr := q[0]
		q = q[1:]

		for i := 0; i < 4; i++ {
			nx := curr.x + dx[i]
			ny := curr.y + dy[i]

			if nx >= 0 && nx < n && ny >= 0 && ny < m && dist[nx][ny] > dist[curr.x][curr.y]+1 {
				dist[nx][ny] = dist[curr.x][curr.y] + 1
				q = append(q, struct{ x, y int }{nx, ny})
			}
		}
	}

	maxDist := -1
	startX := -1
	startY := -1

	for i := 0; i < n; i++ {
		for j := 0; j < m; j++ {
			if dist[i][j] > maxDist {
				maxDist = dist[i][j]
				startX = i
				startY = j
			}
		}
	}

	dist2 := make([][]int, n)
	for i := range dist2 {
		dist2[i] = make([]int, m)
		for j := range dist2[i] {
			dist2[i][j] = int(1e9)
		}
	}

	dist2[startX][startY] = 0
	q = []struct{ x, y int }{{startX, startY}}

	for len(q) > 0 {
		curr := q[0]
		q = q[1:]

		for i := 0; i < 4; i++ {
			nx := curr.x + dx[i]
			ny := curr.y + dy[i]

			if nx >= 0 && nx < n && ny >= 0 && ny < m && dist[nx][ny] > 0 && dist2[nx][ny] > dist2[curr.x][curr.y]+1 {
				dist2[nx][ny] = dist2[curr.x][curr.y] + 1
				q = append(q, struct{ x, y int }{nx, ny})
			}
		}
	}

	maxDist2 := -1
	endX := -1
	endY := -1

	for i := 0; i < n; i++ {
		for j := 0; j < m; j++ {
			if dist2[i][j] != int(1e9) && dist2[i][j] > maxDist2 {
				maxDist2 = dist2[i][j]
				endX = i
				endY = j
			}
		}
	}

	return []int{startX, startY, endX, endY}
}