import "container/list"

type state struct {
	row, col, dir int
	moves         int
}

func minimumMoves(grid [][]int) int {
	n := len(grid)
	if n <= 0 || len(grid[0]) <= 0 {
		return -1
	}

	q := list.New()
	q.PushBack(state{0, 0, 0, 0})

	visited := make([][][]bool, n)
	for i := range visited {
		visited[i] = make([][]bool, n)
		for j := range visited[i] {
			visited[i][j] = make([]bool, 2)
		}
	}
	visited[0][0][0] = true

	for q.Len() > 0 {
		curr := q.Front()
		q.Remove(curr)
		s := curr.Value.(state)

		if s.row == n-1 && s.col == n-2 && s.dir == 0 {
			return s.moves
		}

		// Move forward
		if s.dir == 0 { // Horizontal
			if s.col+2 < n && grid[s.row][s.col+2] == 0 && !visited[s.row][s.col+1][0] {
				visited[s.row][s.col+1][0] = true
				q.PushBack(state{s.row, s.col + 1, 0, s.moves + 1})
			}
		} else { // Vertical
			if s.row+2 < n && grid[s.row+2][s.col] == 0 && !visited[s.row+1][s.col][1] {
				visited[s.row+1][s.col][1] = true
				q.PushBack(state{s.row + 1, s.col, 1, s.moves + 1})
			}
		}

		// Rotate
		if s.dir == 0 { // Horizontal
			if s.row+1 < n && grid[s.row+1][s.col] == 0 && grid[s.row+1][s.col+1] == 0 && !visited[s.row][s.col][1] {
				visited[s.row][s.col][1] = true
				q.PushBack(state{s.row, s.col, 1, s.moves + 1})
			}
		} else { // Vertical
			if s.col+1 < n && grid[s.row][s.col+1] == 0 && grid[s.row+1][s.col+1] == 0 && !visited[s.row][s.col][0] {
				visited[s.row][s.col][0] = true
				q.PushBack(state{s.row, s.col, 0, s.moves + 1})
			}
		}

		// Move down/right
		if s.dir == 0 {
			if s.row+1 < n && grid[s.row+1][s.col] == 0 && grid[s.row+1][s.col+1] == 0 && !visited[s.row+1][s.col][0] {
				visited[s.row+1][s.col][0] = true
				q.PushBack(state{s.row + 1, s.col, 0, s.moves + 1})
			}
		} else {
			if s.col+1 < n && grid[s.row][s.col+1] == 0 && grid[s.row+1][s.col+1] == 0 && !visited[s.row][s.col+1][1] {
				visited[s.row][s.col+1][1] = true
				q.PushBack(state{s.row, s.col + 1, 1, s.moves + 1})
			}
		}
	}

	return -1
}