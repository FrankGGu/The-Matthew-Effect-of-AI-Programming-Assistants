package main

type pair struct {
	r, c int
}

func numEnclaves(grid [][]int) int {
	m := len(grid)
	n := len(grid[0])

	q := []pair{}

	for r := 0; r < m; r++ {
		for c := 0; c < n; c++ {
			// If it's a boundary land cell
			if (r == 0 || r == m-1 || c == 0 || c == n-1) && grid[r][c] == 1 {
				q = append(q, pair{r, c})
				grid[r][c] = 0 // Mark as visited/processed to avoid re-adding and cycles
			}
		}
	}

	dirs := []pair{{0, 1}, {0, -1}, {1, 0}, {-1, 0}} // Right, Left, Down, Up

	head := 0
	for head < len(q) {
		curr := q[head]
		head++

		for _, dir := range dirs {
			nr, nc := curr.r+dir.r, curr.c+dir.c

			// Check bounds and if it's an unvisited land cell
			if nr >= 0 && nr < m && nc >= 0 && nc < n && grid[nr][nc] == 1 {
				grid[nr][nc] = 0 // Mark as visited/processed
				q = append(q, pair{nr, nc})
			}
		}
	}

	enclavesCount := 0
	for r := 0; r < m; r++ {
		for c := 0; c < n; c++ {
			if grid[r][c] == 1 {
				enclavesCount++
			}
		}
	}

	return enclavesCount
}