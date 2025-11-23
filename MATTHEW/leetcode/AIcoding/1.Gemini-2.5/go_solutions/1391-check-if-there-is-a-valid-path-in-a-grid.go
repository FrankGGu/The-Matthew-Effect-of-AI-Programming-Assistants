package main

func hasValidPath(grid [][]int) bool {
	m := len(grid)
	n := len(grid[0])

	dr := []int{-1, 1, 0, 0} // 0: Up, 1: Down, 2: Left, 3: Right
	dc := []int{0, 0, -1, 1}

	oppositeDir := []int{1, 0, 3, 2} // Opposite of Up is Down, etc.

	// For each street type (1-6), list of allowed outgoing directions
	// Directions: 0=Up, 1=Down, 2=Left, 3=Right
	streetConnections := [][]int{
		{},            // Dummy for 0 index
		{2, 3},        // Street 1: Left, Right
		{0, 1},        // Street 2: Up, Down
		{1, 2},        // Street 3: Down, Left
		{1, 3},        // Street 4: Down, Right
		{0, 2},        // Street 5: Up, Left
		{0, 3},        // Street 6: Up, Right
	}

	visited := make([][]bool, m)
	for i := range visited {
		visited[i] = make([]bool, n)
	}

	q := [][2]int{} // Queue for BFS: [row, col]

	q = append(q, [2]int{0, 0})
	visited[0][0] = true

	for len(q) > 0 {
		curr := q[0]
		q = q[1:]
		r, c := curr[0], curr[1]

		if r == m-1 && c == n-1 {
			return true
		}

		currentStreetType := grid[r][c]
		allowedDirs := streetConnections[currentStreetType]

		for _, dir := range allowedDirs {
			nr, nc := r+dr[dir], c+dc[dir]

			if nr < 0 || nr >= m || nc < 0 || nc >= n {
				continue
			}

			if visited[nr][nc] {
				continue
			}

			neighborStreetType := grid[nr][nc]
			requiredIncomingDir := oppositeDir[dir]

			neighborAllowsConnection := false
			for _, neighborAllowedDir := range streetConnections[neighborStreetType] {
				if neighborAllowedDir == requiredIncomingDir {
					neighborAllowsConnection = true
					break
				}
			}

			if neighborAllowsConnection {
				visited[nr][nc] = true
				q = append(q, [2]int{nr, nc})
			}
		}
	}

	return false
}