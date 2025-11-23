func blockPlacement(n int, blocks [][]int, queries [][]int) []int {
	grid := make([][]bool, n)
	for i := range grid {
		grid[i] = make([]bool, n)
	}

	for _, block := range blocks {
		for i := block[0]; i < block[0]+block[2]; i++ {
			for j := block[1]; j < block[1]+block[3]; j++ {
				grid[i][j] = true
			}
		}
	}

	result := make([]int, len(queries))
	for i, query := range queries {
		count := 0
		for row := query[0]; row < query[0]+query[2]; row++ {
			for col := query[1]; col < query[1]+query[3]; col++ {
				if row >= 0 && row < n && col >= 0 && col < n && grid[row][col] {
					count++
				}
			}
		}
		result[i] = count
	}

	return result
}