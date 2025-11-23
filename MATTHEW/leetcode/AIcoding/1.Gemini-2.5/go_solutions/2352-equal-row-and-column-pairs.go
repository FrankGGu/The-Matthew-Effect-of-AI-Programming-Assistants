import (
	"fmt"
)

func equalPairs(grid [][]int) int {
	n := len(grid)
	rowCounts := make(map[string]int)

	for i := 0; i < n; i++ {
		rowStr := fmt.Sprintf("%v", grid[i])
		rowCounts[rowStr]++
	}

	pairCount := 0
	for j := 0; j < n; j++ {
		column := make([]int, n)
		for i := 0; i < n; i++ {
			column[i] = grid[i][j]
		}
		colStr := fmt.Sprintf("%v", column)
		if count, ok := rowCounts[colStr]; ok {
			pairCount += count
		}
	}

	return pairCount
}