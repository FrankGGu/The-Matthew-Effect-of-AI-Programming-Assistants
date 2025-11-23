func countSubmatrices(grid [][]int, x int, y int) int {
	m, n := len(grid), len(grid[0])
	count := 0
	for r1 := 0; r1 < m; r1++ {
		for c1 := 0; c1 < n; c1++ {
			for r2 := r1; r2 < m; r2++ {
				for c2 := c1; c2 < n; c2++ {
					xCount := 0
					yCount := 0
					for i := r1; i <= r2; i++ {
						for j := c1; j <= c2; j++ {
							if grid[i][j] == x {
								xCount++
							} else if grid[i][j] == y {
								yCount++
							}
						}
					}
					if xCount == yCount {
						count++
					}
				}
			}
		}
	}
	return count
}