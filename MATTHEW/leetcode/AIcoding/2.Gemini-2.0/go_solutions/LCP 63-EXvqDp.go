func findBall(grid [][]int) []int {
	m := len(grid)
	n := len(grid[0])
	result := make([]int, n)
	for i := 0; i < n; i++ {
		col := i
		for row := 0; row < m; row++ {
			dir := grid[row][col]
			nextCol := col + dir
			if nextCol < 0 || nextCol >= n || grid[row][col] != grid[row][nextCol] {
				col = -1
				break
			}
			col = nextCol
		}
		result[i] = col
	}
	return result
}