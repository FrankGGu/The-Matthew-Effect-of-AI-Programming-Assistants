import (
	"sort"
)

func minTotalDistance(grid [][]int) int {
	rows := make([]int, 0)
	cols := make([]int, 0)

	for i := 0; i < len(grid); i++ {
		for j := 0; j < len(grid[0]); j++ {
			if grid[i][j] == 1 {
				rows = append(rows, i)
				cols = append(cols, j)
			}
		}
	}

	sort.Ints(cols)

	medianRow := rows[len(rows)/2]
	medianCol := cols[len(cols)/2]

	distance := 0
	for i := 0; i < len(rows); i++ {
		distance += abs(rows[i] - medianRow)
	}
	for i := 0; i < len(cols); i++ {
		distance += abs(cols[i] - medianCol)
	}

	return distance
}

func abs(x int) int {
	if x < 0 {
		return -x
	}
	return x
}