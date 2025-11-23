package main

func shortestBridge(grid [][]int) int {
	n := len(grid)
	q := [][]int{}

	dirs := [][]int{{0, 1}, {0, -1}, {1, 0}, {-1, 0}}

	foundIsland := false
	for r := 0; r < n; r++ {
		if foundIsland {
			break
		}
		for c := 0; c < n; c++ {
			if grid[r][c] == 1 {
				dfs(grid, r, c, n, &q)
				foundIsland = true
				break
			}
		}
	}

	distance := 0
	for len(q) > 0 {
		levelSize := len(q)
		for i := 0; i < levelSize; i++ {
			curr := q[0]
			q = q[1:]
			r, c := curr[0], curr[1]

			for _, dir := range dirs {
				nr, nc := r+dir[0], c+dir[1]

				if nr < 0 || nr >= n || nc < 0 || nc >= n {
					continue
				}

				if grid[nr][nc] == 2 {
					continue
				}

				if grid[nr][nc] == 1 {
					return distance
				}

				if grid[nr][nc] == 0 {
					grid[nr][nc] = 2
					q = append(q, []int{nr, nc})
				}
			}
		}
		distance++
	}

	return -1
}

func dfs(grid [][]int, r, c, n int, q *[][]int) {
	if r < 0 || r >= n || c < 0 || c >= n || grid[r][c] != 1 {
		return
	}

	grid[r][c] = 2
	*q = append(*q, []int{r, c})

	dfs(grid, r+1, c, n, q)
	dfs(grid, r-1, c, n, q)
	dfs(grid, r, c+1, n, q)
	dfs(grid, r, c-1, n, q)
}