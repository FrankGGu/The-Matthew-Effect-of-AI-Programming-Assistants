package main

import "container/list"

func hasPath(grid [][]int) bool {
	R := len(grid)
	if R == 0 {
		return false
	}
	C := len(grid[0])
	if C == 0 {
		return false
	}

	// State represents (row, col, time)
	type State struct {
		r, c, t int
	}

	q := list.New()

	// visited[r][c][t_idx] tracks if (r, c) has been visited at time t.
	// `t_idx` goes from 0 to R.
	// If `t >= R`, the safety check for falling obstacles simplifies (they've all passed).
	// So, `visited[r][c][R]` is used to signify "visited at time R or later".
	visited := make([][][]bool, R)
	for i := range visited {
		visited[i] = make([][]bool, C)
		for j := range visited[i] {
			visited[i][j] = make([]bool, R+1) // Time index up to R (inclusive)
		}
	}

	// Directions: stay, up, down, left, right
	dr := []int{0, -1, 1, 0, 0}
	dc := []int{0, 0, 0, -1, 1}

	// isSafe checks if a cell (r, c) is traversable at a given time t.
	// A cell (r, c) is safe at time t if:
	// 1. It's within grid boundaries.
	// 2. `grid[r][c] == 0` (it's not an initial wall).
	// 3. No falling obstacle reaches `(r, c)` at time `t`. An obstacle
	//    from `grid[r_src][c]` reaches `(r, c)` at time `t` if `r_src + t == r`.
	//    So, we check `grid[r-t][c] == 1` if `r-t >= 0`.
	isSafe := func(r, c, t int) bool {
		if r < 0 || r >= R || c < 0 || c >= C {
			return false // Out of bounds
		}
		if grid[r][c] == 1 {
			return false // Initial wall
		}
		// Check for falling obstacles: if r-t >= 0, check the source cell
		// If t >= R, then r-t will always be < 0 for any r in [0, R-1],
		// so this condition (r-t >= 0) will be false, meaning no falling obstacles
		// from above the grid can reach (r,c) at time t.
		if r-t >= 0 && grid[r-t][c] == 1 {
			return false // Hit by a falling obstacle
		}
		return true
	}

	// Initial state: (0, 0) at time 0
	if !isSafe(0, 0, 0) {
		return false // Start is blocked at time 0
	}
	q.PushBack(State{0, 0, 0})
	visited[0][0][0] = true

	for q.Len() > 0 {
		curr := q.Remove(q.Front()).(State)

		// If we reached the destination (R-1, C-1)
		if curr.r == R-1 && curr.c == C-1 {
			return true // Path found
		}

		// Explore neighbors (including staying put)
		for i := 0; i < 5; i++ {
			nr, nc := curr.r+dr[i], curr.c+dc[i]
			nt := curr.t + 1 // Time always increases by 1

			// Check if (nr, nc) is safe at time nt
			if isSafe(nr, nc, nt) {
				// Determine the time index for the visited array.
				// If nt >= R, obstacles from above the grid have already passed.
				// If grid[nr][nc] == 0, then (nr, nc) is permanently safe from this point on.
				// We use R as the index to represent "time R or later".
				timeIdx := nt
				if nt >= R {
					timeIdx = R
				}

				if !visited[nr][nc][timeIdx] {
					visited[nr][nc][timeIdx] = true
					q.PushBack(State{nr, nc, nt})
				}
			}
		}
	}

	return false // No path found
}