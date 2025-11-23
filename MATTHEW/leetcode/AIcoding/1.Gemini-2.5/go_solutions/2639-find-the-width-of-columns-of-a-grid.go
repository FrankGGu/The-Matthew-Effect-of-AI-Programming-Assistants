func findColumnWidth(grid [][]int) []int {
	if len(grid) == 0 || len(grid[0]) == 0 {
		return []int{}
	}

	numCols := len(grid[0])
	numRows := len(grid)

	column