func construct2DArray(original []int, m int, n int) [][]int {
	if len(original) != m*n {
		return [][]int{}
	}

	result := make([][]int, m)
	for i := 0; i < m; i++ {
		result[i] = make([]int, n)
	}

	for k := 0; k < len(original); k++ {
		row := k / n
		col := k % n
		result[row][col] = original[k]
	}

	return result
}