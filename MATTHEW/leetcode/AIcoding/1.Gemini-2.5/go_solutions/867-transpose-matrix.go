func transpose(matrix [][]int) [][]int {
	rows := len(matrix)
	cols := len(matrix[0])

	transposedMatrix := make([][]int, cols)
	for i := range transposedMatrix {
		transposedMatrix[i] = make([]int, rows)
	}

	for i := 0; i < rows; i++ {
		for j := 0; j < cols; j++ {
			transposedMatrix[j][i] = matrix[i][j]
		}
	}

	return transposedMatrix
}