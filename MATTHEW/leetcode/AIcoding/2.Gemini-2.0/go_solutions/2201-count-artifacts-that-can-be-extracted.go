func digArtifacts(n int, artifacts [][]int, dig [][]int) int {
	grid := make([][]bool, n)
	for i := range grid {
		grid[i] = make([]bool, n)
	}

	for _, d := range dig {
		grid[d[0]][d[1]] = true
	}

	count := 0
	for _, a := range artifacts {
		r1, c1, r2, c2 := a[0], a[1], a[2], a[3]
		extractable := true
		for i := r1; i <= r2; i++ {
			for j := c1; j <= c2; j++ {
				if !grid[i][j] {
					extractable = false
					break
				}
			}
			if !extractable {
				break
			}
		}
		if extractable {
			count++
		}
	}

	return count
}