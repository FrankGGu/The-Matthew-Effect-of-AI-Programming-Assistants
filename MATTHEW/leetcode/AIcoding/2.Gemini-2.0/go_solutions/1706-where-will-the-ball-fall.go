func findBall(grid [][]int) []int {
	m := len(grid)
	n := len(grid[0])
	res := make([]int, n)

	for j := 0; j < n; j++ {
		col := j
		for i := 0; i < m; i++ {
			dir := grid[i][col]
			nextCol := col + dir
			if nextCol < 0 || nextCol >= n || grid[i][col] != dir || (nextCol >= 0 && nextCol < n && grid[i][nextCol] == -dir) {
				col = -1
				break
			}
			col = nextCol
		}
		res[j] = col
	}

	return res
}