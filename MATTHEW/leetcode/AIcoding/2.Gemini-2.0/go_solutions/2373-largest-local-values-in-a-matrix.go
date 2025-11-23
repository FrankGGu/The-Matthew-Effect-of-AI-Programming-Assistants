func largestLocal(grid [][]int) [][]int {
	n := len(grid)
	result := make([][]int, n-2)
	for i := range result {
		result[i] = make([]int, n-2)
	}

	for i := 0; i < n-2; i++ {
		for j := 0; j < n-2; j++ {
			maxVal := 0
			for row := i; row < i+3; row++ {
				for col := j; col < j+3; col++ {
					if grid[row][col] > maxVal {
						maxVal = grid[row][col]
					}
				}
			}
			result[i][j] = maxVal
		}
	}

	return result
}