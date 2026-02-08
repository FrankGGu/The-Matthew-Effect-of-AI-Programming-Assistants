func rangeAddQueries(n int, queries [][]int) [][]int {
	matrix := make([][]int, n)
	for i := range matrix {
		matrix[i] = make([]int, n)
	}

	for _, query := range queries {
		row1, col1, row2, col2 := query[0], query[1], query[2], query[3]
		for i := row1; i <= row2; i++ {
			for j := col1; j <= col2; j++ {
				matrix[i][j]++
			}
		}
	}

	return matrix
}