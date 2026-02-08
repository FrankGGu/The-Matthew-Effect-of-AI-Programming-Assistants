import "sort"

func distance(r1, c1, r2, c2 int) int {
	return abs(r1-r2) + abs(c1-c2)
}

func abs(x int) int {
	if x < 0 {
		return -x
	}
	return x
}

func allCellsDistOrder(rows int, cols int, rCenter int, cCenter int) [][]int {
	cells := make([][]int, rows*cols)
	idx := 0
	for i := 0; i < rows; i++ {
		for j := 0; j < cols; j++ {
			cells[idx] = []int{i, j}
			idx++
		}
	}

	sort.Slice(cells, func(i, j int) bool {
		return distance(cells[i][0], cells[i][1], rCenter, cCenter) < distance(cells[j][0], cells[j][1], rCenter, cCenter)
	})

	return cells
}