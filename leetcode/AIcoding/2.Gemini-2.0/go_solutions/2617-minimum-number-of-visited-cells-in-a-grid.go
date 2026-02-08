import "container/list"

func minimumVisitedCells(grid [][]int) int {
	m, n := len(grid), len(grid[0])
	q := list.New()
	q.PushBack([]int{0, 0, 1})
	rowSets := make([]map[int]bool, m)
	colSets := make([]map[int]bool, n)
	for i := 0; i < m; i++ {
		rowSets[i] = make(map[int]bool)
	}
	for i := 0; i < n; i++ {
		colSets[i] = make(map[int]bool)
	}
	rowSets[0][0] = true
	colSets[0][0] = true

	for q.Len() > 0 {
		curr := q.Front()
		q.Remove(curr)
		node := curr.Value.([]int)
		r, c, steps := node[0], node[1], node[2]

		if r == m-1 && c == n-1 {
			return steps
		}

		for i := r + 1; i <= min(m-1, r+grid[r][c]); i++ {
			if _, ok := rowSets[i][c]; !ok {
				q.PushBack([]int{i, c, steps + 1})
				rowSets[i][c] = true
				colSets[c][i] = true
			}
		}

		for j := c + 1; j <= min(n-1, c+grid[r][c]); j++ {
			if _, ok := colSets[j][r]; !ok {
				q.PushBack([]int{r, j, steps + 1})
				rowSets[r][j] = true
				colSets[j][r] = true
			}
		}
	}

	return -1
}

func min(a, b int) int {
	if a < b {
		return a
	}
	return b
}