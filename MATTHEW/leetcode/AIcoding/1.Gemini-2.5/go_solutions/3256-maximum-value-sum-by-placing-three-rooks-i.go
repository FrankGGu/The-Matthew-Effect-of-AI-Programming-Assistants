func maxValueSum(grid [][]int) int {
	rows := len(grid)
	cols := len(grid[0])

	// For each column, find the top 3 values and their row indices.
	// Store them as pairs: {value,