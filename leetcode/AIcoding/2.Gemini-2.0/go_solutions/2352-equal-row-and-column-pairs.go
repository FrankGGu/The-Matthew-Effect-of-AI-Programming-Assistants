func equalPairs(grid [][]int) int {
	n := len(grid)
	count := 0
	for i := 0; i < n; i++ {
		for j := 0; j < n; j++ {
			equal := true
			for k := 0; k < n; k++ {
				if grid[i][k] != grid[k][j] {
					equal = false
					break
				}
			}
			if equal {
				count++
			}
		}
	}
	return count
}