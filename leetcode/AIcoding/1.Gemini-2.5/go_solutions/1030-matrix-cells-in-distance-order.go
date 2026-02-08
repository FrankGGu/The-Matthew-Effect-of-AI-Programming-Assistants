func abs(x int) int {
	if x < 0 {
		return -x
	}
	return x
}

func allCellsDistOrder(R int, C int, r0 int, c0 int) [][]int {
	cells := make([][]int, 0, R*C)

	for r := 0; r < R; r++ {
		for c := 0; c < C; c++ {
			cells = append(cells, []int{r, c})
		}
	}

	sort.Slice(cells, func(i, j int) bool {
		dist_i := abs(cells[i][0]-r0) + abs(cells[i][1]-c0)
		dist_j := abs(cells[j][0]-r0) + abs(cells[j][1]-c0)
		return dist_i < dist_j
	})

	return cells
}