package main

type Orange struct {
	row  int
	col  int
	time int
}

func orangesRotting(grid [][]int) int {
	m := len(grid)
	n := len(grid[0])

	q := []Orange{}
	freshOranges := 0

	for r := 0; r < m; r++ {
		for c := 0; c < n; c++ {
			if grid[r][c] == 2 {
				q = append(q, Orange{r, c, 0})
			} else if grid[r][c] == 1 {
				freshOranges++
			}
		}
	}

	if freshOranges == 0 {
		return 0
	}

	maxTime := 0
	directions := [][]int{{0, 1}, {0, -1}, {1, 0}, {-1, 0}}

	head := 0
	for head < len(q) {
		curr := q[head]
		head++

		maxTime = curr.time

		for _, dir := range directions {
			nr, nc := curr.row+dir[0], curr.col+dir[1]

			if nr >= 0 && nr < m && nc >= 0 && nc < n && grid[nr][nc] == 1 {
				grid[nr][nc] = 2 // Mark as rotten
				freshOranges--
				q = append(q, Orange{nr, nc, curr.time + 1})
			}
		}
	}

	if freshOranges > 0 {
		return -1
	}

	return maxTime
}