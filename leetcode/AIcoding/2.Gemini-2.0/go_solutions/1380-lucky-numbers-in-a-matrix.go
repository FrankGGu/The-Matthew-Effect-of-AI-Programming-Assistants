func luckyNumbers(matrix [][]int) []int {
	m := len(matrix)
	n := len(matrix[0])
	minInRow := make([]int, m)
	maxInCol := make([]int, n)

	for i := 0; i < m; i++ {
		minInRow[i] = matrix[i][0]
		for j := 1; j < n; j++ {
			if matrix[i][j] < minInRow[i] {
				minInRow[i] = matrix[i][j]
			}
		}
	}

	for j := 0; j < n; j++ {
		maxInCol[j] = matrix[0][j]
		for i := 1; i < m; i++ {
			if matrix[i][j] > maxInCol[j] {
				maxInCol[j] = matrix[i][j]
			}
		}
	}

	result := []int{}
	for i := 0; i < m; i++ {
		for j := 0; j < n; j++ {
			if matrix[i][j] == minInRow[i] && matrix[i][j] == maxInCol[j] {
				result = append(result, matrix[i][j])
			}
		}
	}

	return result
}