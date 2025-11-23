func checkValid(matrix [][]int) bool {
	n := len(matrix)
	for i := 0; i < n; i++ {
		rowSet := make(map[int]bool)
		colSet := make(map[int]bool)
		for j := 0; j < n; j++ {
			rowNum := matrix[i][j]
			colNum := matrix[j][i]

			if rowNum < 1 || rowNum > n || colNum < 1 || colNum > n {
				return false
			}

			if rowSet[rowNum] {
				return false
			}
			rowSet[rowNum] = true

			if colSet[colNum] {
				return false
			}
			colSet[colNum] = true
		}
	}
	return true
}