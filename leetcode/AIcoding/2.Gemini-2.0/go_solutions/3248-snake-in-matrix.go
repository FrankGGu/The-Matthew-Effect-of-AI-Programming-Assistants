func snakeInMatrix(matrix [][]int) []int {
	if len(matrix) == 0 || len(matrix[0]) == 0 {
		return []int{}
	}

	rows := len(matrix)
	cols := len(matrix[0])
	result := make([]int, 0, rows*cols)

	for i := 0; i < rows; i++ {
		if i%2 == 0 {
			for j := 0; j < cols; j++ {
				result = append(result, matrix[i][j])
			}
		} else {
			for j := cols - 1; j >= 0; j-- {
				result = append(result, matrix[i][j])
			}
		}
	}

	return result
}