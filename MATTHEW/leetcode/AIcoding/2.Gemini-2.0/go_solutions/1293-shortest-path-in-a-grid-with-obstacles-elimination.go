import "container/list"

func shortestPath(grid [][]int, k int) int {
	m, n := len(grid), len(grid[0])
	if m == 1 && n == 1 {
		return 0
	}

	q := list.New()
	q.PushBack([]int{0, 0, k, 0}) // row, col, remaining k, steps

	visited := make([][][]bool, m)
	for i := range visited {
		visited[i] = make([][]bool, n)
		for j := range visited[i] {
			visited[i][j] = make([]bool, k+1)
		}
	}
	visited[0][0][k] = true

	directions := [][]int{{0, 1}, {0, -1}, {1, 0}, {-1, 0}}

	for q.Len() > 0 {
		curr := q.Front()
		q.Remove(curr)
		currVal := curr.Value.([]int)
		row, col, remainingK, steps := currVal[0], currVal[1], currVal[2], currVal[3]

		for _, dir := range directions {
			newRow, newCol := row+dir[0], col+dir[1]

			if newRow >= 0 && newRow < m && newCol >= 0 && newCol < n {
				if grid[newRow][newCol] == 0 {
					if !visited[newRow][newCol][remainingK] {
						if newRow == m-1 && newCol == n-1 {
							return steps + 1
						}
						q.PushBack([]int{newRow, newCol, remainingK, steps + 1})
						visited[newRow][newCol][remainingK] = true
					}
				} else {
					if remainingK > 0 && !visited[newRow][newCol][remainingK-1] {
						if newRow == m-1 && newCol == n-1 {
							return steps + 1
						}
						q.PushBack([]int{newRow, newCol, remainingK - 1, steps + 1})
						visited[newRow][newCol][remainingK-1] = true
					}
				}
			}
		}
	}

	return -1
}